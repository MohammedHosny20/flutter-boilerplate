# Architecture & State Management Evaluation

**Author:** Mohamad Hosny  
**Task:** CU-86caqfvp4 — Architecture State Management Evaluation (GetX Alternatives & Clean Architecture PoC)  
**PoC feature:** Products catalog ([DummyJSON Products API](https://dummyjson.com/docs/products))

---

## 1. What was built

A production-shaped **Products** feature inside the existing Sourcya Flutter boilerplate:

| Screen | Route | Behavior |
|---|---|---|
| Products list | `/products` | Search, pull-to-refresh, infinite pagination, loading / empty / error |
| Product details | `/products/details/:id` | Full product info, images, reviews, retry on error |

Remote API: `https://dummyjson.com` (products, search, single product).

Legacy GetX features (auth, splash, dashboard, wishlist, settings) were **left intact**. Products is an incremental Clean Architecture + Riverpod island — coexistence with GetX is intentional for gradual migration.

---

## 2. State management comparison — GetX vs Riverpod vs Bloc

### Criteria matrix

| Criterion | GetX (current app) | Riverpod (chosen for Products) | Bloc / Cubit |
|---|---|---|---|
| **DI model** | Service locator (`Get.put` / `Get.find`) | Compile-safe providers (`ref.watch` / `ref.read`) | Manual wiring or get_it / injectable |
| **Compile-time safety** | Weak — typos / missing bindings fail at runtime | Strong — missing providers fail at compile / provider scope | Strong for events/states; DI still often runtime |
| **Testability** | Harder — global Get container, side effects | Excellent — `ProviderContainer` / overrides | Excellent — blocTest, seeded states |
| **Boilerplate** | Very low | Low–medium | Higher (events, states, blocs; Cubit is lighter) |
| **State shape** | Controllers + `.obs` / Rx | `Notifier` / `AsyncNotifier` / family / autoDispose | Explicit Event → State streams |
| **DI + state in one tool** | Yes (GetX does both) | Yes (Riverpod does both) | No — usually Bloc + separate DI |
| **Learning curve** | Low | Medium | Medium–high |
| **Scalability (multi-feature)** | Weakens as globals grow | Strong with feature-scoped providers | Strong with clear event/state contracts |
| **DevTools / debugging** | Limited / informal | Strong (ProviderObserver, Inspector) | Strong (BlocObserver, DevTools) |
| **Community / longevity** | Declining relative to ecosystem | Strong, Flutter-team adjacent | Strong, long-established |
| **Playx compatibility** | Native (Playx built around GetX patterns) | Works side-by-side (`ProviderScope` + existing GetX) | Works side-by-side |
| **Navigation coupling** | Often coupled (`Get.to`, bindings) | Independent (this PoC uses GoRouter) | Independent |
| **Code generation** | Optional / uncommon | Optional (`riverpod_generator`) — not required here | Optional (`freezed` + `bloc`) |
| **Fit for this PoC** | Already powers legacy screens | Best balance for Clean Architecture island | Viable but heavier for list/detail CRUD |

### Why Riverpod for this PoC

- Covers **state + DI** without adding get_it.
- `Notifier` / `AutoDisposeFamilyNotifier` map cleanly to use cases and screen state.
- Feature-scoped providers keep Products isolated from GetX globals.
- Overrides make repository / use case testing straightforward.
- Coexists with Playx + GoRouter without rewriting the shell.

### Why not Bloc for this PoC

- Excellent for complex event-driven flows, but heavier for a catalog list/detail feature.
- Needs a second DI story (get_it / injectable) or manual construction.
- More files (events/states) for the same Products intents (load, search, paginate, retry).
- Still a strong future option if a feature’s business rules become highly event-oriented.

### Why not stay on GetX for new features

- Global mutable service locator (`Get.find`) weakens compile-time safety.
- Controllers and bindings encourage UI ↔ domain coupling over time.
- Harder unit testing without careful reset of the global container.
- Weaker long-term community alignment for large multi-feature apps.
- Fine to **keep** for legacy screens during migration; poor default for **new** Clean Architecture work.

### What coexistence looks like today

```
ProviderScope (Riverpod)
  └── Playx / GetX app shell (legacy bindings, GetView screens)
        └── Products island (Riverpod notifiers + feature di/)
```

Two systems temporarily is accepted so migration can be incremental instead of a big-bang rewrite.

---

## 3. Products feature architecture

### Folder structure

```
lib/app/products/
├── di/
│   └── products_providers.dart   ← composition root (wires data → domain)
├── data/
│   ├── data.dart                 ← data layer barrel (+ re-exports domain)
│   ├── datasource/
│   │   ├── products_remote_data_source.dart
│   │   └── products_remote_data_source_impl.dart
│   ├── model/
│   │   ├── api/product_model.dart
│   │   └── mapper/product_mapper.dart
│   └── repository/
│       └── products_repository_impl.dart
├── domain/
│   ├── domain.dart               ← domain layer barrel
│   ├── entity/product.dart
│   ├── repository/products_repository.dart
│   └── usecase/
│       ├── get_products_usecase.dart      (+ ProductsParams)
│       ├── search_products_usecase.dart
│       └── get_product_details_usecase.dart
└── presentation/
    ├── presentation.dart         ← presentation barrel (+ domain + di)
    ├── products/
    │   ├── provider/products_notifier.dart
    │   ├── view/products_view.dart
    │   └── widgets/...
    └── product_details/
        ├── provider/product_details_provider.dart
        ├── view/product_details_view.dart
        └── widgets/...
```

No feature-level mega-barrel and no `part`/`models.dart` library. Models and mappers are standalone; barrels are **per layer**.

### Dependency rule

```
presentation → di → data
       ↘     ↓    ↙
          domain
```

| Layer | Role |
|---|---|
| **domain** | Entities, repository contract, use cases. No DTOs, no Flutter UI. |
| **data** | Remote IO, API models, mappers, repository implementation. |
| **presentation** | Views + Riverpod notifiers. Calls **use cases only** (via providers). |
| **di** | Feature composition root (sibling of the three layers). Wires data impls → domain abstractions. |

### Import rules

| Where | Import |
|---|---|
| Outside the feature (navigation) | `presentation/presentation.dart` |
| Inside `domain/` | `domain/domain.dart` |
| Inside `data/` | `data/data.dart` |
| Inside `presentation/` | `presentation/presentation.dart` |
| `di/` | `data/data.dart` |

### Domain

- **Entity:** `Product` (+ `ProductDimensions`, `ProductReview`) — Equatable.
- **Contract:** `ProductsRepository`
  - list/search → `ResultFuture<DataWrapper<List<Product>>>`
  - details → `ResultFuture<Product>`
- **Use cases:**
  - `ProductsParams` (`query`, `page`, `pageSize`, optional `CancelToken`)
  - `GetProductsUseCase` / `SearchProductsUseCase`
  - `GetProductDetailsUseCase(id)`
  - empty search falls back to `getProducts` inside `SearchProductsUseCase`

`CancelToken` is created in `BasePagedNotifier` and passed through params so refresh/search can abort the previous Dio request.

### Data

| Piece | Responsibility |
|---|---|
| Remote data source | `_client.getList` / `_client.get` → `NetworkResult<ProductModel>` (`dataKey: products`) |
| `ProductModel` | JSON DTO (+ dimensions / review) |
| `product_mapper.dart` | `toEntity()` extensions → domain |
| `ProductsRepositoryImpl` | `execute(() => dataSource..., mapper: ...)` |

Dedicated client: `productsClientProvider` → `ApiClient.createProductsClient` (`Endpoints.jsonBaseUrl`), separate from the authenticated Sourcya API client.

### Presentation

| Screen | State | UI |
|---|---|---|
| List | `ProductsNotifier` extends `BasePagedNotifier<Product>` | `ProductsView`, search, `ProductItem` |
| Details | `ProductDetailsNotifier` (`AutoDisposeFamilyNotifier` → `DataState<Product>`) | `ProductDetailsView` + content / chips / reviews |

**List / search flow**

```
BasePagedNotifier (CancelToken + request seq)
  → ProductsNotifier.fetchPage
    → UseCase(ProductsParams)
      → ProductsRepository
          execute(..., mapper: toEntity + DataWrapper)
            → ProductsRemoteDataSource
```

**Details flow**

```
ProductDetailsNotifier
  → GetProductDetailsUseCase(id)
    → ProductsRepository.getProductById
        execute(..., mapper: toEntity)
```

Last page: with `getList`, DummyJSON `total` is not mapped into `PageInfo`; last page is inferred when `items.length < pageSize`.

### DI

```
productsClientProvider (core)
  → productsRemoteDataSourceProvider
    → productsRepositoryProvider
      → getProductsUseCaseProvider
      → searchProductsUseCaseProvider
      → getProductDetailsUseCaseProvider
```

Defined in `lib/app/products/di/products_providers.dart`. App root: `ProviderScope` in `main.dart`.

### Core pieces used by Products

| Piece | Path | Role |
|---|---|---|
| `ResultFuture` / `execute` | `lib/core/base/base_repository.dart` | Repo helper over Playx `NetworkResult` |
| Use case bases | `lib/core/base/base_usecase.dart` | `UseCaseWithParams` / `UseCaseWithoutParams` |
| `BasePagedNotifier` | `lib/core/pagination/` | Infinite list + cancel + seq |
| `ResponsivePagedSliverView` | `lib/core/ui/widgets/pagination/` | Paged sliver UI |
| Connection banner | `lib/core/connection/` + `ConnectionStatusWidget` | Online/offline `MaterialBanner` |

`ConnectionStatusWidget` wraps the router child in a root `Scaffold` so banners always have a Material host; the notifier uses `ScaffoldMessenger` from that scaffold’s context.

---

## 4. Trade-offs accepted in this PoC

| Accept | Give up |
|---|---|
| Two state systems temporarily (GetX + Riverpod) | Single global pattern today |
| Slightly more files per feature | Ultra-thin GetX controller style |
| Hand-written models (team convention) | freezed/json_serializable codegen |
| Use cases for simple reads | Calling repository directly from UI |
| `NetworkResult` in domain contracts (not Either/fpdart) | Pure functional Either stack |
| `execute` needs a `mapper` (Playx DS returns `NetworkResult`) | Zero-mapping Agency-style `Future<T>` repos |
| Last-page via `items.length < pageSize` with `getList` | Full DummyJSON `total` in `PageInfo` without extra parsing |
| `CancelToken` on `ProductsParams` (pragmatic Dio cancel) | Pure domain params with zero IO types |

---

## 5. Migration considerations (GetX → Riverpod)

Recommended **incremental** path:

1. New features only → Clean Architecture + Riverpod (this PoC).
2. Migrate one legacy feature at a time (start with read-only remote screens).
3. Replace `PlayxBinding` / `Get.put` with Riverpod providers in feature `di/`.
4. Convert views from `GetView` → `ConsumerWidget`.
5. Use per-layer barrels (`data` / `domain` / `presentation`) — avoid legacy per-screen `imports/` folders for new work.
6. Remove GetX when no controllers remain.

Feasible without a big-bang rewrite. Products proves coexistence is stable.

---

## 6. Recommendation

**Adopt Riverpod + feature-first Clean Architecture for new TMT Flutter work.** Keep GetX only while migrating legacy screens.

Justification:

- Better testability and compile-time safety than GetX.
- Less ceremony than Bloc for typical CRUD/catalog screens (Bloc remains valid for complex event-driven domains).
- Fits Playx (Dio / `PlayxNetworkClient` / GoRouter) without fighting the stack.
- Enables gradual migration with proven coexistence.
- Reusable cores: `base_repository` (`execute` / `ResultFuture`), `base_usecase`, `BasePagedNotifier`, connection status.
- Clear feature layout: `di` + `data` + `domain` + `presentation` with layer barrels.

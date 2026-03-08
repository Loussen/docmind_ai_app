# Paket qaydaları (Pro vs Pro+)

## Limitlər (App + Backend uyğun)

| Plan  | Sənəd sayı | Sənəd başına səhifə | Max fayl ölçüsü (MB) |
|-------|------------|----------------------|----------------------|
| Free  | 2          | 5                    | 10                   |
| Pro   | Limitsiz   | Limitsiz             | 50                   |
| Pro+  | Limitsiz   | Limitsiz             | 100                  |

---

## App (Flutter)

- **Mənbə:** `lib/core/constants/app_constants.dart`
- **Yükləmə icazəsi:** `canUploadProvider` = Pro/Pro+ (aktiv) və ya free limitə çatmayıb.
- **Fayl ölçüsü:** `maxFileSizeMbProvider` plana görə (10 / 50 / 100). Upload ekranında "up to X MB" və upload-dan əvvəl yoxlama.

---

## Backend (Laravel – `laravel_api/`)

- **Config:** `config/docmind.php` – hər plan üçün `max_file_size_mb` (free 10, pro 50, pro_plus 100).
- **Upload:** `DocumentController::store()` plana görə max fayl ölçüsü yoxlanır.
- **Premium sayılma:** `Device::isPremium()` və `User::isPremium()` indi **`Subscription::isActive()`** istifadə edir:
  - `isActive()` = `status === 'active'` **və** (`end_date` yoxdur **və ya** `end_date` gələcəkdir).
  - Aylıq/illik bitəndə (`end_date` keçəndə) istifadəçi artıq premium sayılmır və upload/summary limitlərinə (free) düşür.

---

## Abunə bitəndə (ödəniş olunmayıbsa)

- **Əvvəl:** Backend yalnız `status === 'active'` yoxlayırdı; `end_date` keçsə belə premium qalırdı.
- **İndi:** `Device` və `User` üçün `isPremium()` / `isProPlus()` **`$subscription->isActive()`** ilə işləyir. `Subscription::isActive()` `end_date->isFuture()` yoxlayır, ona görə abunə bitəndən sonra istifadə oluna bilmir (upload free limitə əsasən bloklanır).

---

## Pro vs Pro+ fərqi

- **Fərq:** Yalnız max fayl ölçüsü (Pro 50 MB, Pro+ 100 MB). Sənəd/səhifə hər ikisində limitsiz.
- **Backend:** Hər iki plan üçün `max_file_size_mb` config-də və upload validation-da tətbiq olunur.

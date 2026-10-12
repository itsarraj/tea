# Tea — Google Play Console Submission Guide (2026)

Master reference and exact answers for publishing **Tea: Brutalist Dating Advice** (`com.kraftisium.tea`, v1.0.0) on the Google Play Console.

---

## Part 1: Let us know about the content of your app (App Content)

### 1. Set privacy policy
* **Privacy Policy URL**:
  ```
  https://tea.kraftisium.xyz/privacy
  ```
  *(Direct BFF endpoint: `https://tea.kraftisium.xyz/api/v1/legal/privacy`)*
* **Compliance details**: Hosted with valid HTTPS/SSL, publicly accessible worldwide without login, non-editable HTML neo-brutalist webpage disclosing strictly text-only architecture (zero photo/camera permissions, permanent procedural avatars, 18+ age verification, 1-on-1 advisor consultations, instant in-app account deletion).

---

### 2. Sign-in details (App access)
Google requires working reviewer access if the app has login/onboarding.

* **Selection**: Select **"All or some functionality in my app is restricted"**
* Click **+ Add instructions**:
  * **Instruction name**: `Play Store QA Reviewer Account`
  * **Username / Email**: `playstore@teadating.app`
  * **Password**: `TeaReview2026!`
  * **Phone number**: *(Leave blank)*
  * **Any other instructions**:
    ```
    No 2-factor authentication required. Use the provided email and password to log in. The account has been pre-verified (18+ adult compliance), onboarding completed, assigned an advisor ranking, and pre-populated with dilemmas, community verdicts, and advisor direct consultations.
    ```

---

### 3. Ads
* **Question**: "Does your app contain ads?"
* **Answer**: Select **"No, my app does not contain ads"**
  *(Tea contains no advertising SDKs or third-party ad networks)*.

---

### 4. Content rating (IARC Questionnaire)
Click **Start questionnaire**:
* **Email address**: `support@kraftisium.xyz`
* **Category**: Select **Social or Communication** (or **Social Networking / Dating Advice**)

#### Questionnaire Answers:
* **Violence**: No
* **Sexuality**: No *(App strictly prohibits nudity/explicit material)*
* **Language**: No
* **Controlled Substance**: No
* **Promotion of Age-Restricted Products**: No
* **Miscellaneous / Interactions**:
  * *Does the app allow users to interact or exchange content with other users through text, sharing photos, or audio?* -> **Yes** *(Text only)*
  * *Does the app share the user's current and precise physical location with other users?* -> **No** *(Tea only shares user-selected city or locality name, never precise GPS coordinates)*.
  * *Does the app allow users to purchase digital goods?* -> **No** *(Tea v1.0.0 has no in-app purchases or digital goods enabled in this release)*.
  * *Is the app a web browser or search engine?* -> **No**

---

### 5. Target audience and content
* **Target age group**:
  * Check **18 and over** ONLY.
  * *(DO NOT check any age range below 18. Tea strictly enforces an 18+ age restriction)*.
* **Could your store listing appeal to children?**:
  * Select **No**.

---

### 6. Data safety
Click **Start** or **Manage**:

#### Page 1: Data collection and security
* *Does your app collect or share any of the required user data types?* -> **Yes**
* *Is all of the user data collected by your app encrypted in transit?* -> **Yes** *(HTTPS/TLS)*
* *Do you provide a way for users to request that their data is deleted?* -> **Yes**
* *Delete account URL*:
  ```
  https://tea.kraftisium.xyz/delete-account
  ```

#### Page 2: Data types declaration
Check the boxes for the following categories:

1. **Location**:
   * Check **Approximate location** *(City/Locality)*
   * *(Leave Precise location UNCHECKED)*
2. **Personal info**:
   * Check **Name**
   * Check **Email address**
   * Check **User IDs**
   * Check **Other info** (Date of birth / Age to enforce 18+)
3. **Photos and videos**:
   * **UNCHECK ALL** *(Tea is strictly text-only; zero photo access requested or stored. READ_MEDIA_IMAGES and READ_MEDIA_VIDEO are explicitly blocked in app.config.js and AndroidManifest)*.
4. **Messages**:
   * Check **Other in-app messages** *(1-on-1 advisor consultations and peer advice)*
5. **Device or other IDs**:
   * Check **Device or other IDs** *(Push notification token)*

#### Page 3: Data details (for each checked type)

| Data Type | Collected? | Shared? | Ephemeral? | Optional? | Purpose |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Approximate location** | **Yes** | **No** | **No** | **Yes** (Optional) | App functionality, Personalization |
| **Name** | **Yes** | **No** | **No** | **No** (Required) | App functionality, Account management |
| **Email address** | **Yes** | **No** | **No** | **No** (Required) | App functionality, Account management |
| **User IDs** | **Yes** | **No** | **No** | **No** (Required) | App functionality, Account management |
| **Other info (Age, DOB)**| **Yes** | **No** | **No** | **No** (Required) | 18+ policy enforcement & legal compliance |
| **Other in-app messages** | **Yes** | **No** | **No** | **Yes** (Optional) | App functionality (Advisor messaging) |
| **Device or other IDs** | **Yes** | **No** | **No** | **Yes** (Optional) | App functionality (Push alerts) |

*For all data types: "Is this data processed ephemerally?" -> **No**.*
*For all data types: "Do users have the ability to request data deletion?" -> **Yes**.*

---

### 7. Government apps
* **Question**: "Is your app developed by or on behalf of a government?"
* **Answer**: Select **No**

---

### 8. Financial features
* **Question**: "Does your app provide any financial features?"
* **Answer**: Select **My app doesn't provide any financial features**

---

### 9. Health features
* **Question**: "Does your app provide health features?"
* **Answer**: Select **My app doesn't provide any health features**

---

### 10. Child safety standards (Social / Dating requirement)
* **Safety standards URL**:
  ```
  https://tea.kraftisium.xyz/safety
  ```
  *(Live, valid HTTPS, discloses zero tolerance for CSAE/CSAM, 18+ enforcement, strictly text-only zero-photo architecture, in-app reporting, NCMEC and law enforcement cooperation)*.
* **Contact**:
  * Select: **Use animesh080808@gmail.com, the contact email address associated with this developer account**
* **Declarations (Check both boxes)**:
  - [x] **Tea Dating Advice allows users to report child safety concerns in-app.**
  - [x] **My app complies with all relevant child safety laws, and reports to regional and national authorities.**

---

## Part 2: Manage how your app is organised and presented

### 11. App category and contact details
* **App or game**: Select **App**
* **Category**: Select **Lifestyle** *(or **Social** / **Dating**)*
* **Tags**: Add `Dating`, `Social networking`, `Lifestyle`, `Advice`, `Community`
* **Developer contact details**:
  * **Email address**: `support@kraftisium.xyz`
  * **Phone number**: *(Optional — leave blank)*
  * **Website**: `https://tea.kraftisium.xyz`
* **External marketing**: Checked (recommended)

---

### 12. Set up your Store Listing

#### App Name
```
Tea: Brutalist Dating Advice
```
*(28 characters / 30 max)*

#### Short Description
```
Candid dating advice, community verdicts, red flags, and top advisors. No fluff.
```
*(80 characters / 80 max)*

#### Full Description
```
Welcome to Tea — the raw, neo-brutalist dating advice platform where you get candid reality checks, crowd-sourced verdicts, and guidance from top-rated dating advisors.

No fake filters. No photo swiping fatigue. No sugarcoating. Just the brutal tea on modern dating.

WHAT MAKES TEA DIFFERENT:

🫖 SPILL YOUR DATING DILEMMAS
Stuck on a confusing text? Wondering if you're being ghosted or overreacting? Post your dating situation anonymously or under your advisor handle and get immediate crowd-sourced perspectives.

🚩 THREE-WAY VERDICT VOTING
Cast and receive instant community verdicts on every dilemma:
- 🚩 Red Flag (Run while you can)
- 💚 Green Flag (Keeper behavior)
- ⚖️ Valid / Overreacting (You need a reality check)

🏆 VERIFIED DATING ADVISORS
Browse and follow specialized advisors by topic:
- Situationships & Mixed Signals
- First Date Standards & Ettiquette
- Ghosting, Breadcrumbing & Texting Psychology
- Red Flags, Narcissism & Healthy Boundaries
- Breakup Recovery & Grounded Dating Wisdom

🔒 STRICTLY TEXT-ONLY & TOTAL PRIVACY
We believe dating advice should focus on actions, patterns, and communication — not looks:
- Permanent procedural pixel avatars assigned at onboarding (no photo uploads).
- Zero camera or gallery permissions requested or stored.
- Instant, self-serve account deletion anytime in Settings.
- Strict 18+ adult community enforcement.

💬 PRIVATE 1-ON-1 CONSULTATIONS
Need tailored guidance on a sensitive situation? Start a private direct conversation with top-ranked community advisors.

Download Tea today and stop second-guessing your dating life.

Support & Questions: support@kraftisium.xyz
Privacy Policy: https://tea.kraftisium.xyz/privacy
Safety Standards: https://tea.kraftisium.xyz/safety
```

#### Graphics & Assets
* **App Icon**: `apps/tea/play-store-assets/app-icon-512.png` (512 × 512 PNG, 32-bit color)
* **Feature Graphic**: `apps/tea/play-store-assets/feature-graphic-1024x500.png` (1024 × 500 PNG)
* **Phone Screenshots**: 9:16 vertical neo-brutalist screenshots captured directly from device or simulator.

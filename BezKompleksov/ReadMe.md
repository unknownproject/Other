\# OSINT \& Reverse Engineering Report: Deconstructing "Bez-Kompleksov" Dating Scam Network

\*\*Investigated by:\*\* UNKNOWNPROJECT

\*\*Target Platform:\*\* `bez-kompleksov.com` (and associated white-label clones)

\*\*Infrastructure Provider:\*\* Microsoft Azure

\*\*Financial Operators:\*\* Interactive Online Technologies Oy (Finland), Interactive Online Technologies BV (Netherlands), MediaMars LP (Israel)



\## Overview

This repository contains a full-stack technical audit and structural deconstruction of the commercial dating platform `bez-kompleksov.com`. The investigation reveals a heavily orchestrated, multi-layered fraudulent network designed to trap users in an artificial interaction loop via automated background threads and manual operator manipulation to trigger hidden recursive card billing.



\---



\## Technical Deconstruction



\### 1. Architectural Fraud: Deactivation Over Destruction (Soft Delete Bypass)

The platform intentionally misleads users regarding their right to erasure (violating GDPR Article 17 "Right to be Forgotten" and Federal Law No. 152-FZ). Analysis of the production JavaScript bundle (`main.js`) revealed a hardcoded functional spoofing where the frontend account destruction method points directly to a server-side conservation state:



```javascript

deleteAcc:()=>"/api/accounts/current/freeze",

restoreAcc:()=>"/api/accounts/current/unfreeze"

```



\* \*\*Mechanism:\*\* When a user executes the "Delete Profile" action, the system runs an ordinary `UPDATE` query on the database, toggling visibility but preserving the entire PII data footprint (emails, raw logs, identities).

\* \*\*Behavior:\*\* Seamless automated reactivation (`/unfreeze`) triggers immediately upon any sub-sequent standard `GET` or `POST` authentication request without explicit user re-consent.



\### 2. Infrastructure \& CDN Footprint (Microsoft Azure Exploitation)

The fraudulent platform utilizes mainstream enterprise infrastructure to mask its tenebrous data manipulation and storage overhead:

\* \*\*CDN/Storage Host:\*\* `https://windows.net`

\* \*\*Static Assets Container:\*\* `/user-photo/`

\* \*\*IP Architecture:\*\* Connected to Microsoft Azure nodes (e.g., `52.178.214.89`, Western Europe region).



\#### Vulnerability Discovered: Image Role-Swapping UI Bypass

The frontend application restricts users from deleting their primary/active profile picture (`is\_main == true`) directly through the UI layout. 

\* \*\*Exploit Vector:\*\* By uploading a temporary nominal picture and reassigning it as the primary profile display, the relational flag on the original target photo is demoted (`is\_main = false`).

\* \*\*Result:\*\* The demoted photo bypasses the UI restriction lock, allowing a direct REST client or unmasked UI handler to successfully fire a hard `DELETE` request straight to the Azure Blob Container, permanently purging the target asset from the CDN. Verified via `ResourceNotFound (HTTP 404)` on the original object link.



\### 3. Traffic Proxying \& Fake Identity Harvesters

The domain architecture uses targeted subdomains and proxy sites to bypass modern API restrictions, specifically regarding OAuth token acquisition:

\* \*\*OAuth Relay Domain:\*\* `vkRedirectDomain: "bezkompleksov.club"`

\* \*\*Purpose:\*\* To circumvent domain-level security bans and blacklists on major social networks (VK, Facebook). The app registers App IDs to disposable surrogate club domains, enabling them to safely pull user access tokens (`access\_token`) and harvest private user materials (`scope=photos,friends`) without flagging browser-level malware protections.



\### 4. Behavioral Indicators \& Operational Timings

The platform attempts to simulate an immersive live ecosystem, but completely fractures under human-in-the-loop dependencies:

\* \*\*Background Micro-Services (`realtime.js`):\*\* Web Workers maintain persistent detached `WebSocket` server connections, injecting deterministic arrays of fake profile likes and text pings into active client sessions to trigger instant dopamine spikes (Immersive Love Bombing Automation).

\* \*\*The Lunch Break Anomaly:\*\* Real-time conversational progress sharply dropped to zero across simulated high-conversion profiles precisely at \*\*13:00 local time\*\*, exposing the presence of human data operators working on strict localized office shift parameters and utilizing centralized multi-account CRM setups (e.g., \*ChatOS\* modifications).

\* \*\*Aggressive Activation Scripts:\*\* If transaction metrics fall below threshold metrics (`tokenAmount: 0`), automated text triggers target male egos by initiating provocative psychological pretexts (\*"impotent", "forgot about me", "you've been taken"\*), attempting to prompt paid transactional responses.



\---



\## The "UNKNOWNPROJECT" Manifest



As an ultimate proof of concept, this specific account (`userId: 12083043`) was converted into a permanent canary node:

1\. \*\*Biometric Data Purged:\*\* Real profile faces were programmatically forced into hard deletion utilizing the role-swapping exploit against the Azure Blob API.

2\. \*\*Visual Manifest:\*\* The deleted profile target was replaced with a photographic asset of a cane/walking stick.

3\. \*\*Payload Injected:\*\* The account profile name was modified to `UNKNOWNPROJECT`. The profile bio was modified to host an obfuścated Base64-encoded string masking a direct reference back to this raw GitHub repository path:



```text

aHR0cHM6Ly9naXRodWIuY29tL3Vua25vd25wcm9qZWN0L090aGVyL3Jhdy9yZWZzL2hlYWRzL21hc3Rlci8lRDAlOUYlRDElODAlRDAlQkUlRDElODclRDElODIlRDAlQjglRDAlOUMlRDAlQjUlRDAlQkUnRDElOEYudHh0

```



The system successfully logged the profile into a `/freeze` state, maintaining an empty data matrix holding nothing but the hunter's marker.



\---

\*Disclaimer: This documentation is published strictly for educational, defensive OSINT purposes and to assist infrastructure security teams in recognizing fraudulent white-label dating architectures.\*


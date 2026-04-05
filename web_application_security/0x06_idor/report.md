# **CyberBank Web Application Security Assessment Report**

---

## **1. Introduction**

This report presents the results of a detailed security evaluation of the CyberBank web application. The main goal of this assessment was to uncover vulnerabilities in access control, transaction management, and authentication processes.

The assessment focused on identifying **Insecure Direct Object Reference (IDOR) issues**, logic flaws in financial transactions, and weaknesses in the 3D Secure payment verification system.

Testing was conducted in a controlled lab environment, replicating realistic attack scenarios that could allow malicious actors to access sensitive financial information or manipulate transactions.

---

## **2. Methodology**

The evaluation followed a structured penetration testing approach, combining manual inspection with controlled exploitation.

The primary tool used was Burp Suite, leveraging features such as:

* Interception of HTTP/HTTPS traffic via Proxy
* Request modification through Repeater
* Traffic review using HTTP History
* Manual manipulation of parameters
* Analysis of transaction workflows

Testing involved:

* Enumeration of user IDs and account numbers
* Manipulation of API endpoints
* Attempts to bypass authorization
* Transaction tampering
* Examination of authentication flows, including 3D Secure

The focus was on detecting weaknesses in:

* Enforcement of access control
* Input validation mechanisms
* Transaction integrity
* Authentication binding and verification

---

## **3. Vulnerability Findings**

---

### **3.1 Insecure Direct Object Reference (IDOR)**

#### **Overview**

The application exposes direct references to internal resources, such as account IDs, without proper authorization checks. Modifying these identifiers can grant access to other users’ data.

#### **Technical Details**

The `api/accounts/info/{id}` endpoint returns account information based solely on the supplied ID, without verifying if the logged-in user is authorized to access it. This indicates missing server-side access control validation.

#### **Potential Impact**

* Unauthorized disclosure of financial data
* Exposure of account balances and transaction histories
* Privacy violations
* Heightened risk of targeted financial attacks

#### **Steps to Reproduce**

1. Log in with a valid account
2. Send a request to access account information:

```
api/accounts/info/1sd32....
```

3. Change the account ID:

```
api/accounts/info/652q...
api/accounts/info/4rdf...
```

4. Observe that data from other accounts is returned

#### **Evidence**

* API responses containing multiple users’ data
* No authorization checks apparent in responses

---

### **3.2 Wire Transfer Business Logic Flaw**

#### **Overview**

The wire transfer functionality lacks proper validation, allowing attackers to manipulate transactions to increase balances artificially.

#### **Technical Details**

The system does not properly validate:

* Transaction amounts (including negative values)
* Relationships between source and destination accounts
* Ownership of accounts

This exposes logical flaws that can be exploited.

#### **Potential Impact**

* Unauthorized balance inflation
* Financial fraud
* Compromised integrity of the banking system
* Risk of large-scale abuse

#### **Steps to Reproduce**

1. Start a wire transfer from the dashboard
2. Intercept the request via Burp Suite
3. Modify parameters:

```json
{
  "from_account": "attacker_account",
  "to_account": "attacker_account",
  "amount": 1000
}
```

4. Test additional payloads like negative or high amounts, and unauthorized accounts
5. Send the modified request
6. Observe unexpected balance increases

#### **Evidence**

* Altered payloads
* Account balances exceeding expected values
* Transactions approved despite invalid logic

---

### **3.3 3D Secure Verification Weakness**

#### **Overview**

The 3D Secure implementation does not properly bind OTPs to specific transactions or users, allowing authentication bypass.

#### **Technical Details**

The OTP verification endpoint:

```
POST /api/cards/confirm_payment/{transaction_id}
```

accepts:

```json
{
  "otp": "...",
  "number": "card_number"
}
```

The backend does not ensure the OTP is tied to:

* The transaction
* The card number
* The authenticated user session

This creates opportunities for cross-context abuse.

#### **Potential Impact**

* Unauthorized payment approvals
* Ability to charge other users’ cards
* High risk of financial fraud
* Compromised payment security

#### **Steps to Reproduce**

1. Start a payment with a victim’s card
2. Trigger the 3D Secure process
3. Initiate a separate payment with your card and receive a valid OTP
4. Intercept the confirmation request:

```
POST /api/cards/confirm_payment/{transaction_id}
```

5. Modify the request:

```json
{
  "otp": "VALID_OTP_FROM_ATTACKER",
  "number": "VICTIM_CARD"
}
```

6. Keep the session as the attacker
7. Send the request
8. Observe successful transaction completion

#### **Evidence**

* OTP accepted for a different card
* Transaction executed successfully
* Authentication context not enforced

---

## **4. Additional Observations**

Other security concerns identified include:

* Weak input validation across endpoints
* Predictable object identifiers enabling enumeration
* Poor integration between authentication and authorization
* Error messages exposing internal logic (e.g., “Invalid card number”, “Invalid 3D Secure Code”)

These issues increase exploitability when combined with other vulnerabilities.

---

## **5. Recommendations**

---

### **Access Control (IDOR)**

* Enforce strict server-side authorization checks
* Verify object access against the authenticated user
* Replace predictable IDs with secure identifiers like UUIDs

---

### **Transaction Security**

* Validate all transaction parameters
* Block negative or invalid amounts
* Confirm ownership of source and destination accounts
* Apply transaction integrity verification

---

### **3D Secure Enhancements**

* Bind OTPs to specific transactions, user sessions, and card numbers
* Prevent OTP reuse across contexts
* Implement multi-layer verification mechanisms

---

### **General Security Measures**

* Apply comprehensive input validation and sanitization
* Implement logging and monitoring
* Introduce rate limiting
* Conduct regular penetration testing

---

## **6. Conclusion**

CyberBank contains critical vulnerabilities in access control, transaction processing, and authentication mechanisms.

These flaws allow attackers to:

* Access unauthorized account data
* Manipulate financial transactions
* Bypass payment verification systems

Immediate remediation is required to protect the platform’s security, integrity, and trustworthiness.

---

## **7. References**

* OWASP Top 10 (Broken Access Control, Business Logic Flaws)
* OWASP Web Security Testing Guide
* Burp Suite Documentation
* Standard Web Application Security Testing Practices

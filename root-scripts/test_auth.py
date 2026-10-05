import gpsoauth

EMAIL = "k0994666594@gmail.com"
PWD = "ikxfkroyboeaerut"
ANDROID_ID = "3f4a2ac1e5d6c9b8"

resp = gpsoauth.perform_master_login(EMAIL, PWD, ANDROID_ID)
print("Error:", resp.get("Error", "none"))
token = resp.get("Token", "")
if token:
    print("MASTER_TOKEN_START")
    print(token)
    print("MASTER_TOKEN_END")

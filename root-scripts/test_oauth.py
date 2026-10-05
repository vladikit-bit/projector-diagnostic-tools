import gpsoauth

EMAIL = "k0994666594@gmail.com"
PWD = "ikxfkroyboeaerut"
ANDROID_ID = "3f4a2ac1e5d6c9b8"

# Different auth endpoint: oauth2 service instead of ac2dm
try:
    resp = gpsoauth.perform_oauth(
        EMAIL, PWD, ANDROID_ID,
        service="oauth2:https://www.googleapis.com/auth/homegraph",
        app="com.google.android.gms",
        client_sig="38918a453d07199354f8b19af05ec6562ced5788"
    )
    print("perform_oauth Error:", resp.get("Error", "none"))
    print("Keys:", list(resp.keys()))
    tok = resp.get("Token") or resp.get("Auth")
    if tok:
        print("OAUTH_TOKEN_START")
        print(tok[:60] + "..." if len(tok) > 60 else tok)
        print("OAUTH_TOKEN_END")
except Exception as e:
    print("EXCEPTION:", type(e).__name__, e)

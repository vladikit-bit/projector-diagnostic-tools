#!/usr/bin/env python3
"""Talk to Kodi's JSON-RPC on TCP 9090 (this device speaks raw JSON, not HTTP)."""
import json
import socket
import sys

HOST, PORT = "192.168.0.183", 9090


def rpc(method, *params, timeout=10):
    payload = json.dumps(
        {"jsonrpc": "2.0", "id": 1, "method": method, "params": list(params)}
    ).encode()
    s = socket.create_connection((HOST, PORT), timeout=timeout)
    try:
        s.sendall(payload)
        s.settimeout(timeout)
        buf = b""
        while True:
            try:
                chunk = s.recv(65536)
            except socket.timeout:
                break
            if not chunk:
                break
            buf += chunk
            try:
                return json.loads(buf.decode(errors="replace"))
            except json.JSONDecodeError:
                continue
        return json.loads(buf.decode(errors="replace")) if buf else {"error": "empty"}
    finally:
        s.close()


if __name__ == "__main__":
    m = sys.argv[1]
    p = []
    for raw in sys.argv[2:]:
        # Allow real JSON objects/arrays to be passed through, not just strings.
        try:
            p.append(json.loads(raw))
        except json.JSONDecodeError:
            p.append(raw)
    print(json.dumps(rpc(m, *p), indent=2, ensure_ascii=False))

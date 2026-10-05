import re,sys
def norm(fn):
    out=[]
    for ln in open(fn,encoding='utf-8',errors='replace'):
        s=ln.rstrip('\n')
        s=re.sub(r'^\[\s*\d+\.\d+\]\s*','',s)
        s=re.sub(r'^\d\d-\d\d \d\d:/d/d:/d/d/./d+/s*','',s)
        s=re.sub(r'\[PID:/d+/]','[PID:X]',s)
        s=re.sub(r'\( *\d+\)','(PID)',s)
        s=re.sub(r'\bT:/d+/b','T:X',s)
        s=s.strip()
        if s: out.append(s)
    return out
a=norm(sys.argv[1]); b=norm(sys.argv[2])
sa=set(a); sb=set(b)
onlyA=[l for l in a if l not in sb]
onlyB=[l for l in b if l not in sa]
print(f"### ONLY IN A ({len(onlyA)} lines not present in B)")
for l in onlyA[:50]: print("  A|",l[:190])
print(f"\n### ONLY IN B ({len(onlyB)} lines not present in A)")
for l in onlyB[:50]: print("  B|",l[:190])
print(f"\ncommon={len(sa&sb)}  A_unique={len(sa)} B_unique={len(sb)}")

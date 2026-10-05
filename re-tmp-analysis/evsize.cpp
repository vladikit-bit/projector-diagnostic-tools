#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
struct SystemEvent
{
    uint32_t sequence;
    uint32_t timestamp;
    uint32_t uptimeSeconds;
    float value;
    uint8_t severity;
    bool active;
    char code[32];
};
struct __attribute__((packed)) StoredEvent { uint32_t magic; SystemEvent event; uint32_t checksum; };
int main(){ printf("sizeof(SystemEvent)=%zu sizeof(StoredEvent)=%zu
", sizeof(SystemEvent), sizeof(StoredEvent)); }

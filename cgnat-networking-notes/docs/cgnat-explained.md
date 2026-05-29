# CGNAT Deep Dive

## What is CGNAT?

Carrier-Grade NAT (CGNAT) is defined in RFC 6598. It uses the 100.64.0.0/10 address range as a shared address space between your ISP and your router.

## Detection Methods

### IP Comparison Method
1. Check your router WAN IP (in router admin panel or `ip route`)
2. Check your public IP (`curl ifconfig.me`)
3. If different → you are behind CGNAT

### Traceroute Method
```bash
traceroute 1.1.1.1
```
If you see 100.64.x.x hops, that confirms CGNAT.

## Why It Exists

IPv4 exhaustion. There are not enough public IPv4 addresses for every device. CGNAT lets ISPs share one public IP among hundreds of customers.

## Solutions Summary

| Solution | Difficulty | Cost | Permanent URL |
|---|---|---|---|
| Ngrok | Easy | Free tier | No (changes on restart) |
| Cloudflare Tunnel | Medium | Free | Yes |
| VPS Reverse Proxy | Hard | ~$5/mo | Yes |
| ISP Static IP | Easy | ~$10/mo | Yes |
| IPv6 | Medium | Free (if ISP supports) | Yes |

## Recommended Solution

**Cloudflare Tunnel** — free, permanent, secure, no open ports.

# Your always-on AI agent server

AI agents only work if they are **always on**: they need to react when an email, a message or a booking arrives at 3 am. Your laptop can't do that, but a small server for a few euros a month can.

This repo gives you two ways to get one running, plus ideas for what to build with it.

## Option A: one click (easiest, no terminal)

Hostinger has ready-made AI agent servers: pick one, pay, done.

- **n8n VPS**: visual builder for AI agents and automations
- **OpenClaw / Hermes Agent**: a personal AI assistant that runs 24/7

👉 **[Get an AI agent VPS on Hostinger](https://www.hostinger.com?REFERRALCODE=UJAALESSIGLU)** (choose *VPS → n8n* or one of the 1-click AI agents)

## Option B: any VPS, with this script (full control)

Works on any Ubuntu/Debian VPS (2 GB RAM or more), for example a Hostinger KVM VPS or any other provider.

1. Rent a VPS and point a domain or subdomain to its IP (DNS **A record**, e.g. `agents.yourdomain.com`).
2. Log in as root and run:

```bash
curl -fsSL https://raw.githubusercontent.com/giovannajasmin/ai-agent-server/main/setup.sh | DOMAIN=agents.yourdomain.com TIMEZONE=Europe/Rome bash
```

3. After a few minutes open `https://agents.yourdomain.com` and create your account.

What you get:
- **n8n**, the open-source workflow and AI-agent builder, with its built-in AI Agent node
- **Automatic HTTPS** via Caddy (free Let's Encrypt certificate)
- Data kept in Docker volumes; settings and the encryption key in `/opt/ai-agent-server/.env` (**back this file up**)

## Choose the agent's "brain"

The server runs the agent; the AI model can live wherever you prefer:

| Option | Best for | How |
| --- | --- | --- |
| Hosted model API (OpenAI, Anthropic, Novita, OpenRouter…) | Simplest start | Add the provider's credentials in n8n |
| **Your own private model** on a rented GPU | Data never leaves your servers, flat hourly cost | Use [private-llm-api](https://github.com/giovannajasmin/private-llm-api) and add it in n8n as an *OpenAI-compatible* model with your base URL and key |

## What people build with it

- **Guest / customer assistant**: reads incoming messages, answers FAQs (check-in times, parking, Wi-Fi), escalates anything unusual to a human.
- **Inbox triage**: classifies emails, drafts replies, creates tasks.
- **Daily research brief**: collects news on your topics every morning and sends a summary to Telegram.
- **Document Q&A bot**: answers questions about your PDFs and internal docs.
- **Lead follow-up**: when a form is submitted, enriches the lead and sends a personalised first reply.

## Security checklist

- Use a strong password for the n8n owner account.
- Keep the server updated: `apt update && apt upgrade`.
- Back up `/opt/ai-agent-server/.env`: without the encryption key, saved credentials can't be recovered.
- Only expose what you need; this setup opens ports 80 and 443 only.

## Update n8n

```bash
cd /opt/ai-agent-server && docker compose pull && docker compose up -d
```

## Need it set up for your business?

Custom AI agents for hospitality, customer service and back-office automation: open an issue or contact the author.

## Credits

Built on [n8n](https://github.com/n8n-io/n8n) and [Caddy](https://github.com/caddyserver/caddy). This repo only provides a ready-to-run setup.

*The Hostinger links in this README are referral links.*

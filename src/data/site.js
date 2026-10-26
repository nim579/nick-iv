import { image } from './images';

export const site = {
  url: 'https://nick-iv.me',
  name: 'Nick Iv',
  fullName: 'Nikolay Ivanushkin',
  role: 'CTO & fullstack developer',
  title: 'Nick Iv — CTO & fullstack developer building AI agents',
  description: 'Nikolay Ivanushkin (Nick Iv) is a CTO and fullstack developer. He builds AI agents at Captain, and products used by millions: Teletype and Must.',
  email: 'nick@nick-iv.me'
};

export const menu = [
  { id: 'now', label: 'Captain' },
  { id: 'ai', label: 'AI' },
  { id: 'products', label: 'Products' },
  { id: 'projects', label: 'Projects' },
  { id: 'open-source', label: 'Open source' }
];

export const socials = [
  { name: 'github', label: 'GitHub', link: 'https://github.com/nim579/' },
  { name: 'teletype', label: 'Blog on Teletype', link: 'https://blog.nick-iv.me' },
  { name: 'must', label: 'Must', link: 'https://mustapp.com/@nick-iv' }
];

export const captain = {
  link: 'https://getcaptain.ai',
  stats: [
    { value: '100%', label: 'calls answered' },
    { value: '5 s', label: 'first reply' },
    { value: '+43%', label: 'more appointments' },
    { value: '98', label: 'languages' }
  ],
  trusted: ['Mercedes-Benz', 'Volvo', 'LADA']
};

export const ai = [
  {
    icon: 'agents',
    title: 'Agents in production',
    text: 'Captain talks to real customers in chat, WhatsApp and on the phone. Tools, memory, hand-off to a human and a score for every conversation.'
  },
  {
    icon: 'voice',
    title: 'Voice and telephony',
    text: 'Real-time speech, SIP and Asterisk, low-latency pipelines. A call with an agent has to feel like a call, not like a form.'
  },
  {
    icon: 'knowledge',
    title: 'Knowledge, not guesses',
    text: 'Curated knowledge bases, site sync and gap reports. The agent answers from facts, and tells you what it could not answer.'
  },
  {
    icon: 'engineering',
    title: 'AI-native engineering',
    text: 'Rules, skills and MCP servers around GitLab and Notion. An agent picks up an issue, makes a plan, writes the code and opens a merge request across a multi-repo platform.'
  }
];

export const principles = [
  'Evals before prompts.',
  'A human in the loop, always one click away.',
  'Boring infrastructure, sharp product.'
];

export const products = {
  teletype: {
    link: 'https://teletype.in',
    stats: [
      { label: 'MAU', value: '7M' },
      { label: 'Registered users', value: '3.5M' },
      { label: 'Articles', value: '6M' },
      { label: 'Avg. RPS', value: '480' }
    ],
    bloggers: [
      { name: 'Artemy Lebedev', link: 'https://blog.tema.ru', userpic: image('userpic_lebedev') },
      { name: 'Ilya Varlamov', link: 'https://varlamov.ru', userpic: image('userpic_varlamov') },
      { name: 'Miu Mau', link: 'https://blog.mammamiu.com', userpic: image('userpic_miumau') },
      { name: 'Arkadiy Gershman', link: 'https://urbanblog.ru', userpic: image('userpic_gershman') },
      { name: 'Sergey Stillavin', link: 'https://teletype.in/@stillavin', userpic: image('userpic_stillavin') }
    ],
    art: image('teletype_art_light'),
    artDark: image('teletype_art_dark')
  },
  must: {
    link: 'https://mustapp.com',
    stats: [
      { label: 'MAU', value: '60K' },
      { label: 'Users', value: '550K' },
      { label: 'Movies watched', value: '26M' },
      { label: 'Episodes watched', value: '150M' }
    ],
    art: image('must_art_light'),
    artDark: image('must_art_dark')
  }
};

// Websites and products built for other teams. Staging builds live on dev.nim579.ru.
export const projects = [
  {
    name: 'NOZL',
    text: 'Proprietary trading terminal for a funded-trader programme: execution, risk control, news and analytics in one workspace.',
    link: 'https://nozl.dev.nim579.ru/',
    art: image('projects/nozl')
  },
  {
    name: 'Fura',
    text: 'Digital freight broker on a mission to deliver a zero-waste supply chain.',
    link: 'https://fura.dev.nim579.ru/',
    art: image('projects/fura')
  },
  {
    name: 'Hyperian',
    text: 'US energy tech company focused on renewables: storage systems, software and EV chargers.',
    link: 'https://hyperian.dev.nim579.ru/',
    art: image('projects/hyperian')
  },
  {
    name: 'Foldink',
    text: 'Bioinks and 3D bioprinting materials, with a configurator for custom formulations.',
    link: 'https://foldink.dev.nim579.ru/',
    art: image('projects/foldink')
  },
  {
    name: 'Wireless Overlords',
    text: 'Design, audit and rollout of Wi-Fi and Auto-ID systems for industrial sites. In Russian.',
    link: 'https://wo.dev.nim579.ru/',
    art: image('projects/wo')
  }
];

export const openSource = [
  {
    name: 'do-migrate',
    art: 'do-migrate',
    text: 'PostgreSQL migration tool on Node.js',
    link: 'https://github.com/nim579/do-migrate'
  },
  {
    name: 'node-srv',
    art: 'node-srv',
    text: 'Lightweight static Node.js server',
    link: 'https://github.com/nim579/node-srv'
  },
  {
    name: 'dns_relay',
    art: 'dns_relay',
    text: 'DNS relay for UDP and DoH requests',
    link: 'https://github.com/nim579/dns_relay'
  },
  {
    name: 'fractals',
    art: 'fractals',
    text: 'T-fractals web generator',
    link: 'https://github.com/nim579/fractals'
  },
  {
    name: 'link-enricher',
    art: 'link-enricher',
    text: 'Fetches oEmbed, Open Graph and other info for links',
    link: 'https://github.com/nim579/link-enricher'
  },
  {
    name: 'Envary',
    art: 'envary',
    badge: 'Beta',
    text: 'Lightweight self-hosted environment, config and secrets manager',
    link: 'https://github.com/nim579/Envary'
  }
];

# Doks

Doks is a documentation theme for [Hyas](https://gethyas.com/).

## Demo

- [doks.netlify.app](https://doks.netlify.app/)

## Install

The recommended way to install the latest version of Doks is by running the command below:

```bash
npm create hyas@latest -- --template doks
```

Looking for help? Start with our [Getting Started](https://getdoks.org/docs/start-here/getting-started/) guide.


### Install this project

clone this project to your disk:

```bash
git clone https://github.com/siyehua/doks
```

install package:

```bash
npm install
```

run

```bash
npm run dev
```

## Add or Change Content

### Main Page

Edit style and css `layouts` to see this page change.

Edit content `content/_index.md` to see this page change.

### Blog
Add or Edit Markdown files to `content` to create new pages.

### Config
Edit your config in `config/_default/hyas/doks.toml`

# Vercel

todo

## Documentation

Visit our [official documentation](https://getdoks.org/).


## index.md
### title
```shell
---
title: "Example Post4"
description: "Just an example post."
summary: "You can use blog posts for announcing product updates and features."
date: 2023-09-07T16:27:22+02:00 #TZ='Asia/Shanghai' date +"%Y-%m-%dT%H:%M:%S%z" | sed 's/\([+-][0-9][0-9]\)\([0-9][0-9]\)/\1:\2/'
lastmod: 2023-09-07T16:27:22+02:00 #TZ='Asia/Shanghai' date +"%Y-%m-%dT%H:%M:%S%z" | sed 's/\([+-][0-9][0-9]\)\([0-9][0-9]\)/\1:\2/'
draft: false
weight: 49 # The smaller the weight on the page, the more forward the page will be
categories: []
tags: []
contributors: []
pinned: false
homepage: false
seo:
  title: "" # custom title (optional)
  description: "" # custom description (recommended)
  canonical: "" # custom canonical URL (optional)
  noindex: false # false (default) or true
---
```

## Support

Having trouble? Get help in the official [Doks Discussions](https://github.com/h-enk/doks/discussions).

## Contributing

New contributors welcome! Check out our [Contributor Guides](https://getdoks.org/contribute/) for help getting started.

## Links

- [License (MIT)](LICENSE)
- [Code of Conduct](https://github.com/gethyas/.github/blob/main/CODE_OF_CONDUCT.md)
- [Project Funding](.github/FUNDING.md)
- [Website](https://getdoks.org/)

## Sponsors

Doks is supported by Netlify, Algolia, and several other amazing organizations and inidviduals. [Sponsor Doks!](.github/FUNDING.md) ❤️

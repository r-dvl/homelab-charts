# Homelab Charts
## Table of Contents

- [Personal Helm Charts Repository](#personal-helm-charts-repository)
    - [Available Charts](#available-charts)
    - [Usage](#usage)
    - [Configuration](#configuration)
        - [Customizing Values](#customizing-values)
        - [Using ConfigMaps](#using-configmaps)
        - [Using Traefik as Ingress Controller](#using-traefik-as-ingress-controller)

## Personal Helm Charts Repository

This repository contains Helm charts and docs for self-hosted applications in my homelab. Below is a list of the available charts:

### Available Charts

- **Bazarr**: A companion application to Sonarr and Radarr. It manages and downloads subtitles based on your requirements.
- **Calibre Web**: A web app providing a clean interface for browsing, reading, and downloading eBooks using an existing Calibre database.
- **Cloudflare-ddns**: A tool to update Cloudflare DNS records dynamically.
- **Cloudflared**: A tunneling daemon that proxies traffic from Cloudflare to your local server.
- **Jackett**: A proxy server that translates queries from apps like Sonarr and Radarr into tracker-site-specific http queries.
- **Jellyfin**: An open-source media server that allows you to manage and stream your media.
- **Jellyseerr**: A free and open-source software application for managing requests for your media library.
- **Plex**: A media server that organizes your media and streams it to any device.
- **Prowlarr**: An indexer manager/proxy built on the popular Sonarr/Radarr application base.
- **QBittorrent**: A cross-platform free and open-source BitTorrent client.
- **Radarr**: A movie collection manager for Usenet and BitTorrent users.
- **Sonarr**: A PVR for Usenet and BitTorrent users to download TV shows.
- **Vaultwarden**: An unofficial Bitwarden server implementation written in Rust.

Each chart is located in its respective directory under the `charts` folder.

### Usage

To use any of these charts, add this repository to your Helm client:

```sh
helm repo add my-homelab-charts https://r-dvl.github.io/homelab-charts
helm repo update
```

Then, you can install a chart using:

```sh
helm install <release-name> my-homelab-charts/<chart-name>
```

For example, to install Jellyfin:

```sh
helm install jellyfin my-homelab-charts/jellyfin
```

### Configuration

As a general rule, I use ConfigMaps to set the configuration for these applications. Additionally, I have set up Traefik as the Ingress controller.

#### Customizing Values

To customize the values for each chart, you can create a `values.yaml` file. This file allows you to override the default values provided by the chart.

For example, to customize the configuration for Jellyfin, you can create a `values.yaml` file with the following content:

```yaml
configMap:
  enabled: true
  # Custom configuration for Jellyfin
  data:
    PUID: "1000"
    PGID: "1000"
    TZ: "Europe/Madrid"

ingress:
    enabled: true
    annotations:
        traefik.ingress.kubernetes.io/router.entrypoints: web
    hosts:
        - host: jellyfin.example.com
            paths: ["/"]
    tls:
        - secretName: jellyfin-tls
            hosts:
                - jellyfin.example.com
```

Then, you can install the chart using your custom `values.yaml` file:

```sh
helm install jellyfin my-homelab-charts/jellyfin -f values.yaml
```

This will apply your custom configuration and set up the Ingress with Traefik.

#### Using ConfigMaps

To use ConfigMaps for application configuration, you can define them in your `values.yaml` file. For example:

```yaml
configMaps:
    myConfigMap:
        data:
            config.yaml: |
                someSetting: someValue
```

You can then reference this ConfigMap in your application's deployment configuration.

#### Using Traefik as Ingress Controller

To set up Traefik as the Ingress controller, ensure that the `ingress` section in your `values.yaml` file is properly configured. Here is an example configuration for Traefik:

```yaml
ingress:
    enabled: true
    annotations:
        traefik.ingress.kubernetes.io/router.entrypoints: web
    hosts:
        - host: app.example.com
            paths: ["/"]
    tls:
        - secretName: app-tls
            hosts:
                - app.example.com
```

This configuration will enable Ingress for your application and set up Traefik to route traffic to it.

By following these guidelines, you can customize the configuration of your Helm charts and set up Ingress with Traefik for your applications.

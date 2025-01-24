# Cert Manager
Deployment guide.

## Deployment
```sh
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.2/cert-manager.yaml
```

## Configuration
### Cloudflare Secret
```yaml
apiVersion: v1
kind: Secret
metadata:
 name: cloudflare-api-token-secret
type: Opaque
stringData:
 api-token: -3PGe-D-YbNYChpxsLq9oYxlXlu9el83CWy_oM82
```

### Cluster Issuer
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
 name: le-cluster-issuer
spec:
 acme:
   email: rauldel.valle.lima@gmail.com
   # We use the staging server here for testing to avoid hitting
   server: https://acme-staging-v02.api.letsencrypt.org/directory
   privateKeySecretRef:
     # if not existing, it will register a new account and stores it
     name: le-cluster-issuer-account-key
   solvers:
#     - http01:
#         ingress:
#           class: traefik
     - dns01:
         cloudflare:
           email: rauldel.valle.lima@gmail.com
           apiTokenSecretRef:
             name: cloudflare-api-token-secret
             key: api-token
```

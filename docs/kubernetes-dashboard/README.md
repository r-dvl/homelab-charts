# Kubernetes Dashboard
Installation guide.

## Deployment
```bash
# Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
# Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
```

## Access
### Ingress
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: kubernetes-dashboard
  namespace: kubernetes-dashboard
spec:
  ingressClassName: cloudflare-tunnel
  rules:
    - host: dashboard.rdvl.net
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: kubernetes-dashboard-kong-proxy
                port:
                  number: 443
  tls:
    - hosts:
        - dashboard.example.net
      secretName: dashboard-tls
```

### User
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin
  namespace: kubernetes-dashboard
```

### User Role Binding
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin
  namespace: kubernetes-dashboard
```

### Permanent user token
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: admin
  namespace: kubernetes-dashboard
  annotations:
    kubernetes.io/service-account.name: "admin"
type: kubernetes.io/service-account-token
```
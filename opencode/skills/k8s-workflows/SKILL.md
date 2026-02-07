---
name: k8s-workflows
description: Kubernetes workflow orchestration and operational patterns for multi-cluster environments
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: kubernetes
---

## What I do

- Orchestrate complex Kubernetes operations across multiple clusters
- Provide systematic approaches for common workflows
- Guide human-in-the-loop decision making
- Coordinate kubectl, helm, and istio operations
- Implement safe multi-cluster deployment patterns

## When to use me

Use this when you need to:

- Deploy applications across multiple clusters
- Perform rolling updates with zero downtime
- Troubleshoot issues systematically
- Coordinate service mesh operations
- Manage helm chart deployments
- Handle cluster failover and recovery

## Core Workflows I Support

### Multi-Cluster Deployments

```
Workflow: Deploy-App-To-Multiple-Clusters
1. Validate target clusters and namespaces
2. Deploy to staging cluster first
3. Request human confirmation for production deployment
4. Execute coordinated deployment across clusters
5. Verify deployment health in all clusters
6. Generate deployment summary
```

### Rolling Updates

```
Workflow: Safe-Rolling-Update
1. Check current deployment status
2. Calculate replica count strategy
3. Update with max unavailable percentage
4. Monitor rollback triggers
5. Confirm update completion with human
```

### Service Mesh Operations

```
Workflow: Istio-Management
1. Review current Istio configuration
2. Plan traffic routing changes
3. Execute virtual service updates
4. Verify end-to-end connectivity
5. Validate service mesh health
```

## Multi-Cluster Management

### Cluster Discovery

```bash
# Human confirmation required for cluster operations
echo "Available clusters:"
kubectl config get-contexts --output=name
echo "Current context:"
kubectl config current-context
echo "Namespace in current context:"
kubectl config view --minify | grep namespace
```

### Cross-Cluster Operations

```bash
# Always require confirmation for production changes
confirm_production_operation() {
  if [[ "$CLUSTER_TYPE" == "production" ]]; then
    echo "⚠️  PRODUCTION OPERATION - Human confirmation required"
    read -p "Continue? (y/N): " -n 1 -r
    [[ $REPLY =~ ^[Yy]$ ]] || exit 1
  fi
}

# Deploy with cluster validation
deploy_to_clusters() {
  local app_name=$1
  local clusters=("${@:2}")

  for cluster in "${clusters[@]}"; do
    echo "📍 Deploying $app_name to $cluster"
    kubectl config use-context "$cluster"
    # Deployment commands here
  done
}
```

## Safety and Human-in-the-Loop

### Always Require Confirmation For:

- Production cluster deployments
- Service deletion operations
- Major configuration changes
- Rolling restarts with impact
- Drain or cordon operations

### Pre-flight Checks

```bash
# Verify cluster connectivity
check_cluster_health() {
  local cluster=$1

  kubectl config use-context "$cluster" || {
    echo "❌ Failed to switch to cluster: $cluster"
    return 1
  }

  kubectl get nodes || {
    echo "❌ Cluster $cluster is not accessible"
    return 1
  }

  echo "✅ Cluster $cluster is healthy"
  return 0
}
```

## Helm Integration Patterns

### Chart Deployment Workflow

```bash
# Helm operations with validation
deploy_with_helm() {
  local chart_path=$1
  local namespace=$2
  local values_file=$3

  # Pre-deployment checks
  helm lint "$chart_path" || return 1
  helm template "$chart_path" --namespace="$namespace" | kubectl apply --dry-run=client -f -

  # Human confirmation required for production
  if [[ "$namespace" == "production" ]]; then
    confirm_production_operation
  fi

  # Deploy
  helm upgrade --install "$RELEASE_NAME" "$chart_path" \
    --namespace="$namespace" \
    --values="$values_file" \
    --wait \
    --timeout=10m
}
```

## Istio Integration Patterns

### Service Mesh Management

```bash
# Istio operations with safety checks
istio_traffic_management() {
  local service=$1
  local weight_percentage=$2

  echo "🔄 Routing $weight_percentage% traffic to $service"

  # Verify Istio installation
  kubectl get crd virtualservices | grep istio || {
    echo "❌ Istio not installed in current cluster"
    return 1
  }

  # Apply traffic split with confirmation
  echo "Proposed VirtualService update:"
  cat <<EOF
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: $service
spec:
  http:
  - route:
    - destination:
        host: $service-v1
        weight: $((100 - weight_percentage))
      - destination:
        host: $service-v2
        weight: $weight_percentage
EOF

  confirm_production_operation
  kubectl apply -f -
}
```

## Troubleshooting Workflows

### Systematic Debug Approach

```bash
# Structured troubleshooting process
troubleshoot_deployment() {
  local deployment_name=$1
  local namespace=$2

  echo "🔍 Troubleshooting $deployment_name in $namespace"

  # 1. Check deployment status
  kubectl get deployment "$deployment_name" -n "$namespace" -o wide

  # 2. Check pod logs for errors
  kubectl logs -l app="$deployment_name" -n "$namespace" --since=10m

  # 3. Check resource constraints
  kubectl top pod -l app="$deployment_name" -n "$namespace"

  # 4. Check events for issues
  kubectl get events -n "$namespace" --field-selector involvedObject.name="$deployment_name"

  # 5. Verify service connectivity
  kubectl get svc -l app="$deployment_name" -n "$namespace"

  echo "📊 Troubleshooting complete - review output above"
}
```

## Usage Examples

### Multi-Cluster Deployment

```
Human: "Deploy my app v1.2 to all production clusters"
Me: I'll orchestrate deployment across production clusters:

1. 🔍 Discovering available production clusters
2. 📋 Validating deployment configuration
3. 🚀 Deploying to staging cluster first for validation
4. 👤 Awaiting human confirmation before production deployment
5. 🌐 Coordinating rollout across production clusters
6. ✅ Verifying deployment health in all clusters
7. 📊 Generating deployment summary

Would you like me to proceed with staging deployment first?
```

### Rolling Update with Safety

```
Human: "Update my nginx deployment to 1.25 with rolling update"
Me: I'll execute safe rolling update:

1. 📊 Current status: nginx deployment, 3 replicas, 100% healthy
2. 🧮 Strategy: 25% max unavailable, progressive rollout
3. 👤 Human confirmation required for production update
4. 🔄 Executing rolling update with monitoring
5. 📈 Tracking update progress and rollback triggers
6. ✅ Verifying update completion and health

Proceed with rolling update? (will require confirmation at 25% and 75% completion)
```

## Integration with Your Existing Skills

This skill works seamlessly with:

- **git-commit**: Commit your k8s configuration changes
- **pull-request**: Create PRs for k8s manifest updates
- **code-review**: Review your kubernetes configurations
- **docs-readme**: Document your k8s setup and workflows
- **test-driven-development**: Test your k8s configurations

## How I Enhance Your Workflow

Instead of you remembering complex kubectl commands:

- Describe what you want to accomplish
- I'll suggest the safest approach
- I'll require human confirmation for risky operations
- I'll coordinate across multiple tools and clusters
- I'll document everything for your git workflow

Think of me as your Kubernetes operations orchestrator - I handle the complexity, you make the strategic decisions.

Ready to start with a specific workflow or question!

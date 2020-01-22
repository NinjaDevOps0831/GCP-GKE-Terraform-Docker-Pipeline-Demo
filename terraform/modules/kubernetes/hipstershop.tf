resource "kubernetes_namespace" "current" {
  metadata {
    name = var.hipstershop_namespace
    labels = {
      istio-injection = "enabled"
    }
  }
}

data "template_file" "hipstershop-argo-app" {
  template = "${file("./manifests/hipstershop-argo-app.yml")}"
  vars     = {
    app_name              = "hipstershop-${var.environment}"
    github_demo_owner     = var.github_demo_owner
    github_demo_reponame  = var.github_demo_reponame
    project               = var.project_id
    k8s_cluster_url       = local.endpoint
    app_namespace         = var.argocd_install ? element(concat(kubernetes_namespace.argocd.*.id, list("")), 0) : "argocd"
    destination_namespace = var.hipstershop_namespace
    manifests_dir         = "kubernetes/overlays/${var.environment}"
  }
}

resource "k8s_manifest" "hipstershop-argo-app" {
  provider   = k8s.management-cluster
  content    = data.template_file.hipstershop-argo-app.rendered
  depends_on = [
    k8s_manifest.argocd,
    kubernetes_namespace.current,
    kubernetes_secret.argocd-cluster-secret,
  ]
}

resource "null_resource" "switch-default-namespace" {
  provisioner "local-exec" {
    command = <<SCRIPT
      kubectl config set-context "${local.context}" --namespace "${var.hipstershop_namespace}"
    SCRIPT
  }
  triggers = {
    always = uuid()
  }
  depends_on = [kubernetes_namespace.current]
}

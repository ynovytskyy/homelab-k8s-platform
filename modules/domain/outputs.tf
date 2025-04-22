
output "namespaces" {
  value = {
    for env, ns in kubernetes_namespace.namespace : env => {
      name = ns.metadata[0].name
    }
  }
  description = "Map of environment names to their corresponding namespace names"
}

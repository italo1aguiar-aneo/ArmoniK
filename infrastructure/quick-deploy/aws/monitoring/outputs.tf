output "monitoring" {
  description = "Monitoring endpoint URLs"
  value       = {
    seq        = (local.seq_use ? {
      host    = module.seq.0.host
      port    = module.seq.0.port
      url     = module.seq.0.url
      web_url = module.seq.0.web_url
      use     = true
    } : {})
    grafana    = (local.grafana_use ? {
      host = module.grafana.0.host
      port = module.grafana.0.port
      url  = module.grafana.0.url
      use  = true
    } : {})
    prometheus = (local.prometheus_use ? {
      host = module.prometheus.0.host
      port = module.prometheus.0.port
      url  = module.prometheus.0.url
      use  = true
    } : {})
    cloudwatch = (local.cloudwatch_use ? {
      name   = module.cloudwatch.0.name
      region = var.region
      use    = true
    } : {})
    fluent_bit = {
      container_name = module.fluent_bit.container_name
      image          = module.fluent_bit.image
      tag            = module.fluent_bit.tag
      is_daemonset   = module.fluent_bit.is_daemonset
      configmaps     = {
        envvars = module.fluent_bit.configmaps.envvars
        config  = module.fluent_bit.configmaps.config
      }
    }
  }
}
{{/* Expand the name of the chart. */}}
{{- define "app-deployment.name" -}}
{{- if .Values.app.name }}
{{- .Values.app.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}

{{- define "app-deployment.fullname" -}}
{{- default .Release.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "app-deployment.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Common labels */}}
{{- define "app-deployment.labels" -}}
app.kubernetes.io/name: {{ include "app-deployment.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/release: {{ .Values.app.release }}
app.kubernetes.io/team: {{ .Values.app.team }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
helm.sh/chart: {{ include "app-deployment.chart" . }}
app.kubernetes.io/part-of: argocd
{{- end }}

{{/* Match labels to find this instance */}}
{{- define "app-deployment.matchLabels" -}}
app.kubernetes.io/name: {{ include "app-deployment.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Selector labels for load balancing */}}
{{- define "app-deployment.selector" -}}
app.kubernetes.io/name: {{ include "app-deployment.name" . }}
{{- end -}}

{{/* FQDN for K8s service */}}
{{- define "app-deployment.svc-name" -}}
{{ include "app-deployment.name" . }}.{{ .Release.Namespace }}.svc.cluster.local
{{- end -}}

{{/* Additional labels to be added to pod */}}
{{- define "app-deployment.additionalPodLabels" -}}
{{- if .Values.deployment.podLabels -}}
{{- range $key, $value := .Values.deployment.podLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end }}

{{/* Ingress Annotations */}}
{{- define "app-deployment.ingessAnnotations" -}}
{{- if eq .Values.config.INGRESS_TYPE "internal" -}}
kubernetes.io/ingress.class: "nginx-internal"
{{- else -}}
kubernetes.io/ingress.class: "nginx"
{{- end }}
nginx.ingress.kubernetes.io/proxy-body-size: "10m"
{{- end }}

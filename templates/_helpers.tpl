<<<<<<< HEAD
{{/*
Expand the name of the chart.
*/}}
{{- define "mychart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mychart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mychart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mychart.labels" -}}
helm.sh/chart: {{ include "mychart.chart" . }}
{{ include "mychart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mychart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mychart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mychart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mychart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
=======
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
>>>>>>> 2045eed (change_repo_details)
{{- end }}

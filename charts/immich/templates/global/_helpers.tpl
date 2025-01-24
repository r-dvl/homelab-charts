{{- define "immich.serviceAccountName" -}}
{{- if .Values.global.serviceAccount.name -}}
{{ .Values.global.serviceAccount.name }}
{{- else -}}
{{ include "immich.fullname" . }}-sa
{{- end -}}
{{- end }}

{{- define "immich.labels" -}}
app.kubernetes.io/name: {{ include "immich.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "immich.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}

{{- define "immich.name" -}}
{{ .Chart.Name }}
{{- end }}
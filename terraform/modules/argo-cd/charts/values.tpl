argocd-apps:
  applications:
    django-app:
      namespace: argocd
      project: default
      source:
        repoURL: '${github_repo}'
        path: django-app/charts
        targetRevision: '${github_branch}'
        helm:
          valueFiles:
            - values.yaml
      destination:
        server: https://kubernetes.default.svc
        namespace: default
      syncPolicy:
        automated:
          prune: true
          selfHeal: true

  repositories:
    django-app:
      url: '${github_repo}'

  repoConfig:
    insecure: 'true'
    enableLfs: 'true'

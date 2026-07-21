# Contributing

Thanks for helping improve SamuraiPermissionFlow.

## Before opening an issue

- Search existing issues to avoid duplicates.
- Reproduce bugs with the latest `main` branch.
- Include the affected permission, iOS version, Xcode version, and whether the issue occurs on a simulator, a physical device, or both.
- Do not include sensitive application data, credentials, or private vulnerability details in a public issue.

## Pull requests

1. Fork the repository and create a focused branch from `main`.
2. Keep each pull request scoped to one problem or improvement.
3. Preserve the existing public API unless a breaking change is explicitly discussed.
4. Keep the package iOS-first, async/await friendly, and free of external dependencies.
5. Add stable tests for pure mapping or helper logic when practical. Do not trigger real system permission dialogs in tests.
6. Run the required checks before submitting:

```bash
swift build
swift test
```

Update [README.md](README.md) only when user-facing behavior or documented API changes. Describe the motivation, implementation, and test results in the pull request.

Use clear commit messages, for example:

```text
fix: avoid duplicate location continuation resumes
```

By contributing, you agree that your changes will be licensed under the repository's [MIT License](LICENSE).

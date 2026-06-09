return {
    -- Use the project-pinned templ via `go tool` so the LSP version always
    -- matches `templ generate` (avoids version-skew staleness). -gopls-remote
    -- lets templ's embedded gopls join/create a shared gopls daemon.
    cmd = { "go", "tool", "templ", "lsp", "-gopls-remote=auto" },
    filetypes = { "templ" },
    root_markers = { "go.mod", "go.work", ".git" },
}

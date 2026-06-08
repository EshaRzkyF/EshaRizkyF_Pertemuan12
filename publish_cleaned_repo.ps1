param(
    [string]$RemoteUrl = "https://github.com/EshaRzkyF/EshaRizkyF_Pertemuan12.git",
    [string]$SourceDir = (Get-Location).Path
)

Write-Host "Publish helper started"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is not installed or not available in PATH. Install Git before running this script."
    exit 1
}

$tmp = Join-Path $env:TEMP "publish_repo_$(Get-Random)"
Write-Host "Cloning remote repo to temporary folder: $tmp"
git clone $RemoteUrl $tmp
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to clone remote repository. Check RemoteUrl and your network / credentials."
    exit 1
}

Write-Host "Copying cleaned files from '$SourceDir' to clone (excluding .git)"
# Use robocopy for reliable copy on Windows (preserve attributes). Exclude .git folder.
$robocopyCmd = "Robocopy `"$SourceDir`" `"$tmp`" /MIR /XD `"$SourceDir\.git`" `"$SourceDir\ai_model\*.pkl`" `"$SourceDir\Notebook`" `"$SourceDir\.ipynb_checkpoints`" /XF *.pkl *.ipynb tampilan.png"
Write-Host $robocopyCmd
cmd.exe /c $robocopyCmd | Out-Null

Push-Location $tmp
try {
    git add -A
    git commit -m "Clean: remove large model files and notebook; update .gitignore"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Nothing to commit or commit failed. (exit code: $LASTEXITCODE)"
    }

    Write-Host "Pushing to remote..."
    git push origin main
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Push failed. You may need to enter credentials or set up a PAT/SSH key."
        exit 1
    }
    Write-Host "Push succeeded. Repository updated: $RemoteUrl"
} finally {
    Pop-Location
    Write-Host "Cleaning temporary folder: $tmp"
    Remove-Item -LiteralPath $tmp -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "Publish helper finished"

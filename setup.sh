#!/usr/bin/env bash
# ============================================================
#  게임 정보 카드 생성기 - GitHub 업로드 스크립트 (Mac / Linux / Git Bash)
# ============================================================
#
#  사용 전 준비:
#   1. https://github.com 에 로그인
#   2. 우측 상단 + 버튼 → New repository 클릭
#   3. 저장소 이름 입력 (예: game-card-generator)
#   4. Public 선택, "Add a README" 등은 모두 체크 해제 (빈 저장소 생성)
#   5. Create repository 클릭 후, 보이는 HTTPS URL을 복사
#      예: https://github.com/kangzombie/game-card-generator.git
#
#  실행:  bash setup.sh
# ============================================================

set -e

echo ""
echo "========================================"
echo " 게임 정보 카드 생성기 - GitHub 업로드"
echo "========================================"
echo ""

# git 설치 확인
if ! command -v git &> /dev/null; then
    echo "[에러] Git이 설치되어 있지 않습니다."
    echo "       https://git-scm.com/downloads 에서 설치 후 다시 실행하세요."
    exit 1
fi

# 스크립트가 있는 폴더로 이동
cd "$(dirname "$0")"
echo "작업 폴더: $(pwd)"
echo ""

# 이미 git 저장소면 안내
if [ -d ".git" ]; then
    echo "[안내] 이미 git 저장소로 초기화되어 있습니다."
    echo "       변경사항만 커밋/푸시하시려면 아래 명령을 사용하세요."
    echo "         git add ."
    echo "         git commit -m \"수정 메시지\""
    echo "         git push"
    exit 0
fi

# 저장소 URL 입력
read -rp "GitHub 저장소 URL을 붙여넣고 Enter (예: https://github.com/사용자명/저장소명.git): " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "[에러] URL이 입력되지 않았습니다. 종료합니다."
    exit 1
fi

# 사용자 정보 확인 (없으면 입력받기)
if [ -z "$(git config user.name)" ]; then
    read -rp "Git 사용자 이름을 입력하세요 (예: 강민우): " GITUSER
    git config --global user.name "$GITUSER"
fi

if [ -z "$(git config user.email)" ]; then
    read -rp "Git 이메일을 입력하세요 (예: kangzombie@gmail.com): " GITEMAIL
    git config --global user.email "$GITEMAIL"
fi

echo ""
echo "---- 실행 시작 ----"
echo ""

git init
git branch -M main
git add .
git commit -m "Initial commit: 게임 정보 카드 생성기"
git remote add origin "$REPO_URL"

echo ""
echo "---- GitHub에 푸시 ----"
echo " (브라우저 로그인 창이 뜨거나 토큰을 묻는다면 GitHub 계정으로 인증해주세요)"
echo ""
git push -u origin main

echo ""
echo "========================================"
echo " 완료! GitHub에서 저장소를 확인해보세요."
echo " $REPO_URL"
echo "========================================"
echo ""

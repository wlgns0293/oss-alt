1. Part A 풀이: 문제별로 사용한 명령어와 그렇게 조합한 이유
GitHub 숫자 ID 202568486으로 계산한 파라미터는 S=6, H=14, D=23, E=csv, G=B, L=MIT이다. 대부분 grep으로 줄을 고르고 awk·sort·uniq로 세는 파이프로 풀었다.

A01에서는 wc -l로 access.log 전체 줄 수를 구했다. 이어 grep 'srv6$'로 담당 서버 기록만 골라 줄 수를 세고 그 결과에서 다시 grep 'POST'를 사용해 POST 요청 수를 셌다.

A02에서는 grep 'srv6$'로 담당 서버 기록을 고른 다음 awk '{print $6}'으로 상태코드만 추출했다. 여기에 sort | uniq -c를 이어서 사용해 같은 상태코드끼리 모아 각각의 횟수를 셌다.

A03에서는 담당 서버 기록의 세 번째 필드인 IP를 awk로 추출했다. sort | uniq -c로 IP별 접속 횟수를 센 후 sort -nr | head -n 5로 횟수가 많은 상위 5개를 출력했다.

A04의 9월 23일 14시 요청 수는 grep '2026-09-23 14:'와 wc -l로 셌다. 전체 서버 기준이라 srv6 조건은 넣지 않았다.

A05에서는 awk '$8=="srv6" && $6==500'으로 서버가 srv6이고 상태코드가 500인 줄만 골라 results/srv6_500.log에 저장했다. 그다음 wc -l로 해당 줄의 수를 세고 tail -n 3으로 마지막 세 줄을 확인했다.

A06에서는 awk로 srv6 기록의 7번째 필드인 전송 바이트를 합산하고 기록 수도 셌다. 합계를 기록 수로 나눠 평균을 구하고 printf로 소수점 둘째 자리까지 출력했다.

A07에서는 grep 'srv6$' | head -n 10으로 담당 서버 기록의 첫 10줄을 가져왔다. 그 결과에 sed를 적용해 srv6를 SERVER-6으로, GET을 get으로 바꿨다. head를 먼저 해야 담당 서버 10줄만 바뀐다.

A08에서는 awk -F,로 CSV의 쉼표를 필드 구분자로 지정해 B학과 학생 수와 중간고사 평균을 계산했다. 최고점자는 B학과 기록을 sort -t, -k4,4nr로 중간고사 점수가 높은 순서로 정렬한 뒤 head -n 1로 찾아 이름과 점수만 출력했다.

A09에서는 grep ',B,'로 B학과 학생 기록을 원래 파일 순서대로 골랐다. sed로 이름 앞뒤의 다른 필드를 제거해 이름만 남기고 이름 첫 글자에 \U를 적용해 대문자로 바꿨다.

CSV 파일을 찾는 A10은 find data/files/d6 -type f -name "*.csv"로 d6과 하위 폴더를 검색했다. 찾은 경로는 sort로 정렬해 출력하고 같은 검색 결과의 줄 수를 wc -l로 세어 파일 개수를 구했다.

A11에서는 tar -cvf results/a11.tar data/files/d6으로 d6 폴더를 묶었다. -v 옵션이 출력한 파일 목록은 results/a11.txt에 저장했다.

A12에서는 grep -c ',MIT'로 MIT 라이선스를 사용하는 프로젝트 수를 셌다. 이어 grep ',GPL,'로 GPL 프로젝트를 고르고 별점 필드를 기준으로 내림차순 정렬한 뒤 head -n 3으로 상위 3개를 출력했다.

A13에서는 chmod 750 scripts/*.sh로 스크립트 권한을 소유자 rwx, 그룹 r-x, 기타 사용자 권한 없음으로 설정했다. ls -l scripts로 실제 적용된 권한을 확인했다.

A14에서는 기존 top_ip가 있을 경우 rm -f top_ip로 제거했다. 이후 ln -s results/a03.txt top_ip로 심볼릭 링크를 만들고 ls -l top_ip로 링크가 가리키는 대상을 확인했다.

저장소 최상위의 run_all.sh에서는 for script in scripts/a*.sh 반복문으로 A01부터 A14까지의 스크립트를 실행하도록 했다.
2. Part B VIM 편집: 사용한 VIM 명령과 순서
원본 data/config.txt를 results/config_edited.txt로 복사한 후 VIM으로 열었다.

먼저 :%s/localhost/srv6.chosun.local/g로 파일 안의 localhost를 변경했다. 이어 :61로 61번째 줄로 이동하고 V9j로 61~70번째 줄을 선택한 뒤 :norm i#로 각 줄 맨 앞에 #을 붙였다. 마지막으로 :g/DEPRECATED/d로 해당 문자열이 들어간 줄을 삭제하고 :wq로 저장했다.

주석 처리할 줄 번호가 정해져 있었기 때문에 줄을 삭제하기 전에 주석 작업을 먼저 했다. 삭제를 먼저 하면 뒤쪽 줄 번호가 바뀔 수 있다. 편집 결과와 과정은 각각 results/config_edited.txt와 recordings/vim.cast에 남겼다.
3. Part C Docker 이미지: 이미지 이름과 만든 과정
최종 Docker 이미지 이름은 wlgns0293/oss_alt:final이다. Ubuntu 24.04 컨테이너를 실행하고 내부에 git과 tree를 설치한 다음 GitHub에서 oss-alt 저장소를 clone했다.

컨테이너 안의 저장소에서 bash run_all.sh를 실행하고 tree results로 결과를 확인했다. 출력에는 A01~A14 결과 파일, a11.tar, config_edited.txt, srv6_500.log가 포함되어 있었다.

컨테이너에서 나온 후 docker ps -a로 사용한 컨테이너를 확인하고 docker commit으로 이미지를 생성했다. 마지막으로 wlgns0293/oss_alt:final을 Docker Hub에 push했다. 출력된 이미지 digest는 sha256:f6a06eeb6cf389d438fd7c304c17421e5785dd4622e4656520ed00f16f015058이다. 작업 기록은 recordings/docker.cast에 저장했다.
4. Git 기록: 브랜치 구성, fast-forward·3-way 병합 커밋, 충돌 해결 병합 커밋 해시, revert 커밋 해시
원격 저장소에는 main, part-a1, part-a2, part-b, part-c, feature-conflict 브랜치가 남아 있다. Part A~C 작업은 별도 브랜치에서 진행한 후 main에 반영했다. fast-forward로 반영된 작업의 결과 커밋은 Part A의 7ad4a88, Part B의 c258f1e, Part C의 d92f66c이다. fast-forward라 병합 커밋이 따로 생기지 않아, 병합 후 main의 커밋 해시를 적었다.

충돌 실습에서는 공통 커밋 b4e039c에서 main과 feature-conflict가 갈라졌다. main의 수정 커밋 f7963f0과 feature-conflict의 수정 커밋 28b72f8이 merge_practice.txt의 같은 줄을 다르게 변경해 충돌이 발생했다. VIM에서 충돌 표시를 제거하고 파일 내용을 Merged version으로 정리했다. 두 커밋을 부모로 가진 3-way 충돌 해결 병합 커밋은 a73191c이다.

이후 Temporary change를 추가한 커밋 cf9c5c8을 만든 뒤 git revert --no-edit HEAD로 그 변경을 되돌렸다. 자동 생성된 메시지를 유지한 revert 커밋은 78d2462이다. git log --oneline --branches --graph에서 브랜치의 분기와 병합, revert 커밋을 확인했다. 충돌 해결 과정은 recordings/conflict.cast에 기록했다.
5. 라이선스 선택 근거
저장소 최상위에 MIT 라이선스를 적용했다. 과제에서 요구한 세 기준으로 보면, MIT는 수정한 코드를 공개하도록 요구하지 않고 파생물을 반드시 MIT와 동일한 라이선스로 배포하도록 강제하지 않으며 상업적 이용도 허용한다. 다만 복사본이나 소프트웨어의 상당 부분을 배포할 때는 원래 저작권 표시와 허가 문구를 포함해야 한다.

따라서 이 실습 저장소의 코드를 다른 사람이 사용하거나 수정할 수 있는 범위를 넓게 허용하면서 원저작자의 표시는 유지할 수 있다는 점이 MIT를 선택한 이유이다(참고: https://opensource.org/license/mit).
6. 막힌 문제와 해결: 3 건 이상, 오류 메시지 원문과 해결 방법
첫째, WSL에서 docker info를 처음 실행했을 때 permission denied while trying to connect to the docker API at unix:///var/run/docker.sock이 출력됐다. Docker 서버에 접근할 권한이 없어 wlgns 사용자를 docker 그룹에 추가하고 newgrp docker를 실행했다. 이후 docker info에 Server 정보가 표시됐고 docker run --rm hello-world에서도 Hello from Docker!가 출력됐다.

둘째, 처음 컨테이너에서 GitHub 저장소를 clone할 때 사용자명과 암호를 요구했고 입력 후 remote: Invalid username or token. Password authentication is not supported for Git operations.와 fatal: Authentication failed가 출력됐다. GIT_TERMINAL_PROMPT=0 git ls-remote https://github.com/wlgns0293/oss-alt.git HEAD로 공개 저장소가 인증 없이 조회되는 것을 확인한 뒤 새 컨테이너에서 clone을 다시 시도해 성공했다. 처음 인증 입력창이 나타난 정확한 원인까지는 확인하지 못했다.

셋째, 이미지 이름을 wlgns0293.oss-alt:final로 잘못 입력해 tag does not exist: wlgns0293.oss-alt:final 오류가 발생했다. 계정명과 이미지 저장소 이름은 .이 아닌 /로 구분해야 한다는 점을 확인했다. 이후 과제에서 요구한 밑줄 형태인 wlgns0293/oss_alt:final로 태그를 지정하고 push에 성공했다.

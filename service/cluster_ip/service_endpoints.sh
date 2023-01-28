# snackbar 네임스페이스 생성
kubectl create namespace snackbar

# service, deployment 배포
kubectl apply -f service/service.yaml
kubectl apply -f service/deployment.yaml

# 네임 스페이스를 통한 자원 조회
kubectl get all -n snackbar

# 네임 스페이스를 이용해 서비스의 상세 정보 확인
kubectl get svc order -o wide -n snackbar
kubectl get svc payment -o wide -n snackbar

# 네임스페이스로 모든 엔드포인트 조회 - 파드들의 주소 목록이 구성되어 있지 않았다면 요청 전달이 되지 않기 때문에 서비스 생성 후 반드시 엔드포인트를 확인해 봐야 함!
kubectl get endpoints -n snackbar

# order 와 payment 의 service clusterIP 조회
kubectl get svc order -o jsonpath="{.spec.clusterIP}" -n snackbar
kubectl get svc payment -o jsonpath="{.spec.clusterIP}" -n snackbar


# -------------------------------------------
# 환경 변수를 통해 같은 namespace 에 있는 service 에 요청 보내기

# order container 환경 변수 조회
kubectl exec pod/<order-pod-name> -n snackbar -- env | grep PAYMENT

# payment container 환경 변수 조회
kubectl exec pod/<patment-pod-name> -n snackbar -- env | grep ORDER

# snackbar 네임 스페이스의 order pod 컨테이너 쉘 접속
kubectl exec -it <order-pod-name> -c order -n snackbar -- sh

# order pod 의 컨테이너에서 payment service 로 요청 전송 - service type = clusterIP -> 클러스터 내부에서만 통신이 가능하다.
curl $PAYMENT_SERVICE_HOST:$PAYMENT_SERVICE_PORT/


# -------------------------------------------
# 쿠버네티스 dns 서버를 이용해 service 호출

# order pod 의 컨테이너에서 payment(service 이름) 으로 요청 응답 확인 
kubectl exec <order-pod-name> -c order -n snackbar -- curl -s payment:80

# order 컨테이너의 /etc/hosts 파일 조회 -> -c 옵션이 없으면 파드의 첫 컨테이너로 요청을 보낸다.
# /etc/hosts 에는 자기 자신의 pod ip 만 가지고 있기 때문에 요청 시에 kubernetes 의 dns 서버로 hostIp 를 질의한다.
kubectl exec <order-pod-name> -n snackbar -- cat /etc/hosts

# kube-system 네임스페이스의 모든 리소스 중 dns 서버 리소스 조회 -> 클러스터 구성 시 마스터 노드에 필요한 컴포넌트가 실행되는 영역
# kube-system 의 kube-dns 도 deployment, service, replicaset, pod 오브젝트로 관리된다.
kubectl get all -n kube-system | grep kube-dns

# kube-dns 서버 설정 확인
kubectl exec <order-pod-name> -n snackbar -- cat /etc/resolv.conf

# search snackbar.svc.cluster.local svc.cluster.local cluster.local us-central1-c.c.savvy-pagoda-375305.internal c.savvy-pagoda-375305.internal google.internal
# nameserver 10.80.0.10
# options ndots:5
# - nameserver: 컨테이너에서 사용할 dns 서버 주소
# - search: 클러스터 내에서 사용할 도메인 접미사 정의
# - svc.cluster.local: 모든 클러스터 로클 서비스 이름에 사용되는 도메인 접미사
# - FQDN(fully qualified domain name): <서비스이름>.<네임스페이스>.svc.cluster.local
# - FQDN 으로 dns server 에 service ip 조회



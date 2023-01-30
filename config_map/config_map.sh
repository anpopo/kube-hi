# 컨피그 맵 - 리터럴 방식으로 생성
kubectl create configmap greeting-config --from-literal=STUDENT_NAME=안세형 --from-literal=MASSAGE=안녕

# 컨피그맵 정보 확인
kubectl get configmap greeting-config -o yaml

# 파드 생성
kubectl apply -f config_map/hello-app.yaml

# 매핑된 환경 변수 확인
kubectl exec pod/hello-app -- curl -XGET localhost:8080

kubectl delete pod/hello-app

# -------------------------------
# 컨테이너에 envFrom 속성으로 configMapRef 를 이용해 환경 변수 등록
kubectl apply -f config_map/hello-app_env_from.yaml

# 확인용 포트 포워딩
kubectl port-forward pod/hello-app 8080:8080

# 매핑된 환경 변수 확인
kubectl exec pod/hello-app -- curl -XGET localhost:8080

kubectl delete pod/hello-app

# 컨피그 맵 삭제
kubectl delete configmap greeting-config

# ------------------------------------------------------------------
# fromFile 속성을 이용한 configmap 생성
kubectl create configmap greeting-config --from-file=config_map/configs

kubectl get configmap greetring-config -o yaml

kubectl apply -f config_map/hello-app_env_from.yaml

kubectl port-forward pod/hello-app 8080:8080

# 매핑된 환경 변수 확인
kubectl exec pod/hello-app -- curl -XGET localhost:8080

kubectl delete pod/hello-app

# 컨피그 맵 삭제
kubectl delete configmap greeting-config


# ------------------------------------------------------------------
# volume mount 를 통한 configmap

kubectl create configmap nginx-config --from-file=config_map/configs_nginx

get configmap nginx-config -o yaml

kubectl apply -f config_map/web-server.yaml

kubectl delete all -l app=myapp

kubectl delete configmap nginx-config
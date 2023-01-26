# Pod object 생성
kubectl apply -f ./label_selector

# 라벨 조회 (--show-labels, -L)
kubectl get pods --show-labels
kubectl get pod -L group

# kubectl 을 통한 label 추가
kubectl label pod hello-app version=v1
kubectl label pod red-app concept=flower element=rose position=bottom version=v1
kubectl label pod blue-app concept=earth element=sky position=top version=v1
kubectl label pod green-app concept=earth element=tree position=bottom version=v1
kubectl label pod green-app concept=earth element=tree position=bottom version=v1

# selector 로 파드 집합 조회 (--selector or -l)
kubectl get pod --selector group=nature -L group,concept,element,position,version
kubectl get pod --selector 'concept in (flower, earch)' -L group,concept,element,position,version
kubectl get pod --selector '!concept' -L group,concept,element,position,version
kubectl get pod --selector 'concept notin (flower, earch)' --show-labels
kubectl get pod --selector group=nature,position!=top --show-labels

# Pod 에 설정된 라벨 업데이트
kubectl label pod hello-app concept=greet version=v2 --overwrite
kubectl label pod blue-app concept=ocean version=v2 --overwrite

# Pod 에 설정된 라벨을 삭제해보자 (key 에 - 부호를 붙인다.)
kubectl label pod hello-app concept- version=v3 --overwrite

# selector 를 사용해 리소스 정리
kubectl delete pod -l group
export TF_ROOT=./
export TF_TARGET_MODULE=root

pre-commit-all:
	pre-commit run --all-files

tfi:
ifndef GITLAB_USERNAME
	$(error GITLAB_USERNAME is undefined)
endif
ifndef GITLAB_PERSONAL_ACCESS_TOKEN
	$(error GITLAB_PERSONAL_ACCESS_TOKEN is undefined)
endif
	terraform -chdir=${TF_ROOT} init \
	-backend-config="address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${GITLAB_TF_BACKEND_NAME}" \
	-backend-config="lock_address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${GITLAB_TF_BACKEND_NAME}/lock" \
	-backend-config="unlock_address=https://${GITLAB_DOMAIN}/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${GITLAB_TF_BACKEND_NAME}/lock" \
	-backend-config="username=${GITLAB_USERNAME}" \
	-backend-config="password=${GITLAB_PERSONAL_ACCESS_TOKEN}" \
	-backend-config="lock_method=POST" \
	-backend-config="unlock_method=DELETE" \
	-backend-config="retry_wait_min=5"

tfa:
	terraform -chdir=${TF_ROOT} apply $(ARGS)

# tfa:
# 	terraform -chdir=${TF_ROOT} -target=module.${TF_TARGET_MODULE} apply

tfd:
	terraform -chdir=${TF_ROOT} destroy

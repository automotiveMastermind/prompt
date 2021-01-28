#! /usr/bin/env sh

set -e

GITHUB_SHA=${GITHUB_SHA:-$(git rev-parse HEAD)}
GITHUB_REF=${GITHUB_REF:=$(git rev-parse --abbrev-ref HEAD)}
GITHUB_REPOSITORY=${GITHUB_REPOSITORY:-"automotivemastermind"}

IMAGE="debian"
VERSION="latest"
OS=
PLATFORMS=

while :; do
		case $1 in
			-o|--os)
				OS="$2 $OS"
				shift
				;;
			-p|--platform)
				PLATFORMS="$2 $PLATFORMS"
				shift
				;;
			-i|--image)
				IMAGE=$2
				shift
				;;
			-v|--version)
				VERSION=$2
				shift
				;;
			--debug)
				set -x
				;;
			?*)
				printf "\n%s\n" "error: unknown argument: $1"
				exit 1
				;;
			*)
				break
				;;
		esac
		shift
	done

if [ -z "${OS:-}" ]; then
	OS="linux"
fi

if [ -z "${PLATFORMS:-}" ]; then
	PLATFORMS="amd64 arm64"
fi

for os in $OS; do
for platform in $PLATFORMS; do
	if [ "$VERSION" = "latest" ]; then
		tag="$IMAGE-$platform"
	else
		tag="$IMAGE-$VERSION-$platform"
	fi

	printf "\nBUILDING:\n  PLATFORM : %s/%s\n  IMAGE    : %s:%s\n  TAG      : %s\n\n" \
		"$os" "$platform" "$IMAGE" "$VERSION" "$tag"

	# build the image
	docker buildx build --pull --load \
		--platform="$os/$platform" \
		--build-arg IMAGE="$IMAGE" \
		--build-arg VERSION="$VERSION" \
		--label=org.opencontainers.image.name=prompt \
		--label=org.opencontainers.image.revision="$GITHUB_SHA" \
		--label=org.opencontainers.image.version="$GITHUB_REF" \
		--label=org.opencontainers.image.source="https://github.com/$GITHUB_REPOSITORY" \
		--tag "ghcr.io/$GITHUB_REPOSITORY/prompt:${tag}" \
		"${PWD}"
done
done

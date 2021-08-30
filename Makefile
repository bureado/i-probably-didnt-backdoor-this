build:
	podman run --rm -v "$(PWD):/app" -w /app  \
		rust@sha256:8463cc29a3187a10fc8bf5200619aadf78091b997b0c3941345332a931c40a64 \
		cargo build --release --locked --target=x86_64-unknown-linux-musl
	b2sum target/x86_64-unknown-linux-musl/release/asdf

docker:
	buildah bud --timestamp 0 --tag asdf
	buildah inspect --format '{{.FromImageID}}' asdf

src.tgz:
	git archive -o src.tgz HEAD

.PHONY: build docker src.tgz

## make build-normal
cacheを利用しないでビルド
一度ビルドし、ローカルにキャッシュが存在する場合はキャッシュが利用される
マルチステージビルドの場合並列で実行される

## make build-cache-from-last, build-cache-from-full
cache-fromでイメージを指定
中間イメージもキャッシュを利用する場合、複数cache-fromを指定する
BUILDKIT_INLINE_CACHE=1をつけないとキャッシュが利用されない
legacyと違い、事前にイメージをpullしておく必要はない

## make build-repo-min, build-repo-max
image repoにキャッシュ専用のイメージをpushする

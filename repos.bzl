"""
Dependencies required to build Anki.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def register_repos():
    "Register required dependency repos."

    # bazel
    ##########

    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "97e70364e9249702246c0e9444bccdc4b847bed1eb03c5a3ece4f83dfe6abc44",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.2/bazel-skylib-1.0.2.tar.gz",
        ],
    )

    # rust
    ########

    # native.local_repository(
    #     name = "rules_rust",
    #     path = "../rules_rust",
    # )

    maybe(
        http_archive,
        name = "rules_rust",
        strip_prefix = "rules_rust-anki-2021-04-09",
        urls = [
            "https://github.com/ankitects/rules_rust/archive/anki-2021-04-09.tar.gz",
        ],
        sha256 = "2821b22e065c1b4dc73610b1d6ccbed7ed4d755b316e7e0641cd079b7abe4900",
    )

    # python
    ##########

    # native.local_repository(
    #     name = "rules_python",
    #     path = "../rules_python",
    # )

    maybe(
        http_archive,
        name = "rules_python",
        strip_prefix = "rules_python-anki-2020-11-04",
        urls = [
            "https://github.com/ankitects/rules_python/archive/anki-2020-11-04.tar.gz",
        ],
        sha256 = "00e444dc3872a87838c2cb0cf50a15d92ca669385b72998f796d2fd6814356a3",
    )

    # native.local_repository(
    #     name = "com_github_ali5h_rules_pip",
    #     path = "../rules_pip",
    # )

    maybe(
        http_archive,
        name = "com_github_ali5h_rules_pip",
        strip_prefix = "rules_pip-anki-2020-11-30",
        urls = [
            "https://github.com/ankitects/rules_pip/archive/anki-2020-11-30.tar.gz",
        ],
        sha256 = "ab4f10967eb87985383a4172d4533dde568b3ff502aa550239eeccead249325b",
    )

    # javascript
    ##############

    # maybe(
    #     http_archive,
    #     name = "build_bazel_rules_nodejs",
    #     urls = [
    #         "file:///c:/anki/release.tar.gz",
    #         "file:///Users/dae/Work/code/dtop/release.tar.gz",
    #     ],
    # )

    # when updating, remember to update pinned versions in package.json
    maybe(
        http_archive,
        name = "build_bazel_rules_nodejs",
        sha256 = "4a5d654a4ccd4a4c24eca5d319d85a88a650edf119601550c95bf400c8cc897e",
        urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/3.5.1/rules_nodejs-3.5.1.tar.gz"],
    )

    # native.local_repository(
    #     name = "esbuild_toolchain",
    #     path = "../esbuild_toolchain",
    # )

    maybe(
        http_archive,
        name = "esbuild_toolchain",
        sha256 = "7385dfb2acce6517fcfdb16480cf18d1959bafb83d8cddc0c1e95779609f762c",
        urls = ["https://github.com/ankitects/esbuild_toolchain/archive/refs/tags/anki-2021-06-01.tar.gz"],
        strip_prefix = "esbuild_toolchain-anki-2021-06-01",
    )

    # sass
    ############

    # native.local_repository(
    #     name = "io_bazel_rules_sass",
    #     path = "../rules_sass",
    # )

    maybe(
        http_archive,
        name = "io_bazel_rules_sass",
        strip_prefix = "rules_sass-anki-2020-12-23",
        urls = [
            "https://github.com/ankitects/rules_sass/archive/anki-2020-12-23.tar.gz",
        ],
        sha256 = "224ae14b8d2166b3ab4c5fa9b2ae1828f30620ac628dc152e6c0859c7853bb97",
    )

    # translations
    ################

    core_i18n_repo = "anki-core-i18n"
    core_i18n_commit = "f1f4a9579386c2b9b28df7d184fa48bff9c05bd1"
    core_i18n_zip_csum = "c6fe31ff792db865ea8133ff1089f17718830550e63727f8605dbfe9a379259d"

    qtftl_i18n_repo = "anki-desktop-ftl"
    qtftl_i18n_commit = "266858de900fd9a6d2cdc5195ca20805f496137e"
    qtftl_i18n_zip_csum = "743915d9402e301797cab96a3d40dd43ad1d6041044c8f7692c541f93a035d2f"

    i18n_build_content = """
filegroup(
    name = "files",
    srcs = glob(["**/*.ftl"]),
    visibility = ["//visibility:public"],
)
exports_files(["l10n.toml"])
"""

    maybe(
        http_archive,
        name = "rslib_ftl",
        build_file_content = i18n_build_content,
        strip_prefix = core_i18n_repo + "-" + core_i18n_commit,
        urls = [
            "https://github.com/ankitects/{}/archive/{}.zip".format(
                core_i18n_repo,
                core_i18n_commit,
            ),
        ],
        sha256 = core_i18n_zip_csum,
    )

    maybe(
        http_archive,
        name = "extra_ftl",
        build_file_content = i18n_build_content,
        strip_prefix = qtftl_i18n_repo + "-" + qtftl_i18n_commit,
        urls = [
            "https://github.com/ankitects/{}/archive/{}.zip".format(
                qtftl_i18n_repo,
                qtftl_i18n_commit,
            ),
        ],
        sha256 = qtftl_i18n_zip_csum,
    )

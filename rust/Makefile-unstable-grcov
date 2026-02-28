### Prerequisite:
# - llvm-tools-preview: rustup component add llvm-tools-preview --toolchain nightly
# - grcov: cargo install grcov

RUST_TOOLCHAIN := +nightly
OUT_DIR := target/debug
PROFILE_PATTERN := $(OUT_DIR)/coverage-%p-%m.profraw
PROFDATA := $(OUT_DIR)/coverage.profdata
LCOV := $(OUT_DIR)/lcov.info

SYSROOT := $(shell rustc $(RUST_TOOLCHAIN) --print sysroot 2>/dev/null)
LLVM_PROFDATA := $(firstword $(wildcard $(SYSROOT)/bin/llvm-profdata $(SYSROOT)/lib/rustlib/*/bin/llvm-profdata))

ifeq ($(LLVM_PROFDATA),)
	$(error llvm-profdata not found. Install with: rustup component add llvm-tools-preview --toolchain nightly)
endif

install:
	@echo "install grcov..."
	@cargo install grcov

test:
	@echo "running tests with coverage instrumentation..."
	@CARGO_INCREMENTAL=0 \
	RUSTFLAGS="-C instrument-coverage -Zpanic_abort_tests -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Cpanic=abort" \
	RUSTDOCFLAGS="-Cpanic=abort" \
	LLVM_PROFILE_FILE="$(PROFILE_PATTERN)" \
	cargo $(RUST_TOOLCHAIN) test --tests -- --test-threads=1

cover:
	@echo "merging profraw -> profdata..."
	@$(LLVM_PROFDATA) merge -sparse $(OUT_DIR)/*.profraw -o $(PROFDATA)
	@echo "generating lcov with grcov..."
	@grcov $(OUT_DIR) -s . --binary-path ./$(OUT_DIR) -t lcov --branch --ignore-not-existing -o $(LCOV) \
	    --ignore '/*' \
	    --ignore 'examples/*' \
	    --ignore 'tests/*' \
	    --ignore 'target/*'
	@echo "lcov saved to $(LCOV)"

build-linux-gnu:
	@echo "Building kartel for linux gnu..."
	@cargo build -p kartel --release --target x86_64-unknown-linux-gnu


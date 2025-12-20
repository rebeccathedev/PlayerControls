.PHONY: all build clean test demo install help

SCHEME_FRAMEWORK = PlayerControls
SCHEME_DEMO = PlayerControlsDemo
CONFIGURATION = Release
BUILD_DIR = build
DERIVED_DATA = $(BUILD_DIR)/DerivedData

all: build

help:
	@echo "PlayerControls Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  build      - Build the PlayerControls framework (Release)"
	@echo "  debug      - Build the PlayerControls framework (Debug)"
	@echo "  test       - Run tests"
	@echo "  demo       - Build the demo application"
	@echo "  clean      - Clean build artifacts"
	@echo "  install    - Build and copy framework to /Library/Frameworks (requires sudo)"
	@echo "  help       - Show this help message"

build:
	@echo "Building PlayerControls framework ($(CONFIGURATION))..."
	xcodebuild -scheme $(SCHEME_FRAMEWORK) \
		-configuration $(CONFIGURATION) \
		-derivedDataPath $(DERIVED_DATA) \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		clean build

debug:
	@echo "Building PlayerControls framework (Debug)..."
	xcodebuild -scheme $(SCHEME_FRAMEWORK) \
		-configuration Debug \
		-derivedDataPath $(DERIVED_DATA) \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		clean build

test:
	@echo "Running tests..."
	xcodebuild -scheme $(SCHEME_FRAMEWORK) \
		-derivedDataPath $(DERIVED_DATA) \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		test

demo:
	@echo "Building PlayerControlsDemo..."
	xcodebuild -scheme $(SCHEME_DEMO) \
		-configuration $(CONFIGURATION) \
		-derivedDataPath $(DERIVED_DATA) \
		CODE_SIGN_IDENTITY="" \
		CODE_SIGNING_REQUIRED=NO \
		clean build

clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR)
	xcodebuild -scheme $(SCHEME_FRAMEWORK) clean
	@echo "Clean complete."

install: build
	@echo "Installing PlayerControls.framework to /Library/Frameworks..."
	@echo "This requires administrator privileges."
	sudo cp -R $(DERIVED_DATA)/Build/Products/$(CONFIGURATION)/PlayerControls.framework /Library/Frameworks/
	@echo "Installation complete."

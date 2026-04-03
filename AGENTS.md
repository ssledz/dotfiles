# AGENTS.md

This file provides guidelines for agentic coding agents operating in this repository.

## Build/Lint/Test Commands

### General Structure
This repository is a collection of dotfiles managed with GNU Stow. It contains configuration files for various tools like zsh, vim, tmux, and others.

### Testing
- No specific test suite exists for this repository as it's a collection of configuration files
- Each component (zsh, vim, etc.) should be individually tested for functionality

### Linting
- No automated linting is configured in the repository structure
- Each configuration file should be validated manually or through tools specific to their respective systems

### Formatting
- Configuration files follow no common formatting standards as they're tool-specific configurations
- Each configuration file should follow the format and conventions of its respective tool

## Code Style Guidelines

### Directory Structure
- Each configuration component (zsh, vim, tmux) is organized in its own subdirectory
- Files should be placed within appropriate directories matching the tool they configure

### Naming Conventions
- Configuration files typically follow standard naming conventions for each tool:
  - zsh: `.zshrc`, `.zprofile`
  - vim: `.vimrc`, `.vim/` directory
  - tmux: `.tmux.conf`
- Files should be named consistently with their purpose

### Imports and Dependencies
- This repository doesn't have traditional imports or dependencies as it's a collection of configuration files
- Any external plugins are managed through git submodules

### Error Handling 
- Configuration files generally don't implement error handling
- Validation must happen in each component independently

### Types and Documentation
- No type definitions exist in this repository as it's configuration files only
- Each file should include appropriate comments for clarity

### Language-Specific Guidelines
#### zsh Configuration Files:
- Use modern zsh syntax where available, but maintain compatibility with standard shells
- Place aliases and functions in appropriate files within the zsh directory

#### vim Configuration Files:
- Use modern vim syntax and features where supported
- Organize plugins in appropriate subdirectories within the vim directory

#### tmux Configuration:
- Use standard tmux configuration syntax
- Keep keybindings intuitive and consistent

## Code Review Guidelines for Agents

Agents should verify that:
1. Configuration files are logically organized in appropriate directories
2. Files don't have conflicting names that might cause stow issues
3. All external dependencies referenced are properly tracked as git submodules

## Special Instructions for Cursor/Copilot

### Copilot Rules
No specific Copilot rules are defined in this repository.

### Cursor Rules
No specific Cursor rules are defined in this repository.

## Development Practices

1. When making changes to configuration files, validate the setup in actual environments
2. Test each component individually as they are independent configurations
3. When adding new modules, use `git submodule add` to properly track external dependencies

## Agent Task Priorities
1. Verify configuration file organization and directory structure
2. Ensure proper git submodule tracking for external dependencies  
3. Validate that files are properly structured to be compatible with GNU Stow
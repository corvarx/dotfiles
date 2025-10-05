import os
import sys

def get_file_sizes(folder_path):
    """Get all files in folder and subfolders with their sizes."""
    file_list = []

    for root, dirs, files in os.walk(folder_path):
        for file in files:
            file_path = os.path.join(root, file)
            try:
                size = os.path.getsize(file_path)
                file_list.append((file_path, size))
            except (OSError, FileNotFoundError):
                # Skip files that can't be accessed
                pass

    return file_list

def format_size(size_bytes):
    """Convert bytes to human-readable format."""
    for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
        if size_bytes < 1024.0:
            return f"{size_bytes:.2f} {unit}"
        size_bytes /= 1024.0
    return f"{size_bytes:.2f} PB"

def main():
    if len(sys.argv) < 2:
        print("Usage: python script.py <folder_path>")
        sys.exit(1)

    folder_path = sys.argv[1]

    if not os.path.exists(folder_path):
        print(f"Error: Folder '{folder_path}' does not exist.")
        sys.exit(1)

    print(f"\nScanning folder: {folder_path}")
    files = get_file_sizes(folder_path)

    # Sort by size (largest first)
    files.sort(key=lambda x: x[1], reverse=True)

    print(f"\nFound {len(files)} files. Top files by size:\n")
    print(f"{'Size':<15} {'File Path'}")
    print("-" * 80)

    for file_path, size in files:
        print(f"{format_size(size):<15} {file_path}")

if __name__ == "__main__":
    main()

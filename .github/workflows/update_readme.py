import os
import re

def extract_tools(dockerfile_path):
    tools = []
    try:
        with open(dockerfile_path, 'r') as file:
            lines = file.readlines()
            for line in lines:
                match = re.search(r'apt-get install -y (.*)', line)
                if match:
                    tools += match.group(1).split()
                else:
                    # Add support for other package managers if needed
                    pass
    except FileNotFoundError:
        print(f"Error: {dockerfile_path} not found.")
    return tools

def update_readme(tools, readme_path):
    try:
        with open(readme_path, 'r') as file:
            lines = file.readlines()
        
        start = next(i for i, line in enumerate(lines) if line.startswith("### Installed Tools"))
        end = next((i for i, line in enumerate(lines[start+1:], start+1) if line.startswith("###")), len(lines))
        
        new_lines = lines[:start + 1]
        new_lines.append("\n")
        for tool in tools:
            new_lines.append(f"- {tool}\n")
        new_lines += lines[end:]
        
        with open(readme_path, 'w') as file:
            file.writelines(new_lines)
    except FileNotFoundError:
        print(f"Error: {readme_path} not found.")
    except StopIteration:
        print("Error: README format is incorrect. '### Installed Tools' section not found.")

if __name__ == "__main__":
    dockerfiles = ["kali/Dockerfile", "redteam/Dockerfile"]  # Add paths to all relevant Dockerfiles
    all_tools = []
    for dockerfile in dockerfiles:
        all_tools += extract_tools(dockerfile)
    
    readme_path = "README.md"
    update_readme(all_tools, readme_path)

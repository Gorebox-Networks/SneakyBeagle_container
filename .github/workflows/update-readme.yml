import os
import re

def extract_tools(dockerfile_path):
    tools = []
    with open(dockerfile_path, 'r') as file:
        lines = file.readlines()
        for line in lines:
            match = re.search(r'apt-get install -y (.*)', line)
            if match:
                tools += match.group(1).split()
    return tools

def update_readme(tools, readme_path):
    with open(readme_path, 'r') as file:
        lines = file.readlines()
    
    start = lines.index("### Installed Tools\n")
    end = start
    for i in range(start + 1, len(lines)):
        if lines[i].startswith("###"):
            end = i
            break
    
    new_lines = lines[:start + 1]
    for tool in tools:
        new_lines.append(f"- {tool}\n")
    new_lines += lines[end:]
    
    with open(readme_path, 'w') as file:
        file.writelines(new_lines)

if __name__ == "__main__":
    dockerfiles = ["kali/Dockerfile", "redteam/Dockerfile"]  # Add paths to all relevant Dockerfiles
    all_tools = []
    for dockerfile in dockerfiles:
        all_tools += extract_tools(dockerfile)
    
    readme_path = "README.md"
    update_readme(all_tools, readme_path)

import os, sys, subprocess, socket, requests
from colorama import Fore, Style

# --- CONFIGURATION ---
VERSION = "5.0.0"
REPO_URL = "https://github.com"

# --- 1. THE UNIVERSAL INSTALLER & DEPENDENCY MANAGER (Integrated) ---
def bootstrap():
    print(f"{Fore.YELLOW}[*] Initializing Vortex-Sentinel Bootstrapper...{Style.RESET_ALL}")
    
    # Install System Packages
    packages = ["python", "clang", "git", "termux-api", "coreutils", "binutils"]
    subprocess.run(["pkg", "update", "-y"])
    for pkg in packages:
        subprocess.run(["pkg", "install", pkg, "-y"])
    
    # Install Python Logic Dependencies
    subprocess.run(["pip", "install", "requests", "colorama", "bs4", "scapy"])

    # 2. FROM-SCRATCH C++ ENGINE (High-Speed Recon Core)
    cpp_source = """
    #include <iostream>
    #include <sys/socket.h>
    #include <arpa/inet.h>
    #include <unistd.h>
    int main(int argc, char** argv) {
        if(argc < 2) return 1;
        for(int i=1; i<=1024; i++) {
            int s = socket(AF_INET, SOCK_STREAM, 0);
            struct sockaddr_in a;
            a.sin_family = AF_INET; a.sin_port = htons(i); a.sin_addr.s_addr = inet_addr(argv[1]);
            struct timeval t = {0, 150000};
            setsockopt(s, SOL_SOCKET, SO_SNDTIMEO, &t, sizeof(t));
            if(connect(s, (struct sockaddr*)&a, sizeof(a)) == 0) 
                std::cout << "[+] Port Open: " << i << std::endl;
            close(s);
        }
        return 0;
    }
    """
    with open("engine.cpp", "w") as f: f.write(cpp_source)
    subprocess.run(["clang++", "engine.cpp", "-o", "engine"])
    print(f"{Fore.GREEN}[✔] Polyglot Core Armed Successfully.{Style.RESET_ALL}")

# --- 3. THE UPDATE & FIX LOGIC ---
def repair_and_update():
    print(f"{Fore.RED}[!] Self-Healing & Updating...{Style.RESET_ALL}")
    subprocess.run(["git", "fetch", "--all"])
    subprocess.run(["git", "reset", "--hard", "origin/main"])
    bootstrap() # Re-verify dependencies
    print(f"{Fore.GREEN}[+] System Synchronized.{Style.RESET_ALL}")

# --- 4. THE MAIN ORCHESTRATOR ---
class VortexSentinel:
    def __init__(self):
        self.target = ""

    def banner(self):
        os.system('clear')
        print(f"{Fore.RED}██╗   ██╗ ██████╗ ██████╗ ████████╗███████╗██╗  ██╗")
        print(f"██║   ██║██╔═══██╗██╔══██╗╚══██╔══╝██╔════╝╚██╗██╔╝")
        print(f"╚██╗ ██╔╝██║   ██║██████╔╝   ██║   █████╗   ╚███╔╝ ")
        print(f" ╚████╔╝ ██║   ██║██╔══██╗   ██║   ██╔══╝   ██╔██╗ ")
        print(f"  ╚██╔╝  ╚██████╔╝██║  ██║   ██║   ███████╗██╔╝ ██╗")
        print(f"   ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝{Fore.WHITE} v{VERSION}")
        print(f"{Fore.YELLOW}--- THE SUPREME POLYGLOT TESTING FRAMEWORK ---{Style.RESET_ALL}")
        print(f"{Fore.WHITE}   [ ETHICS: AUTHORIZED TESTING PURPOSES ONLY ]\n")

    def run_recon(self):
        if not self.target: print("[-] Set Target First!"); return
        print(f"{Fore.CYAN}[*] Invoking C++ Socket Engine on {self.target}...{Style.RESET_ALL}")
        subprocess.run(["./engine", self.target])

    def menu(self):
        while True:
            self.banner()
            if self.target: print(f"TARGET: {Fore.GREEN}{self.target}{Style.RESET_ALL}\n")
            print("1. Set Target")
            print("2. Network Recon (C++ Native)")
            print("3. System Intelligence (Bash/Kernel)")
            print("4. Update & Repair System")
            print("5. Exit")
            
            c = input(f"\n{Fore.RED}Vortex > {Style.RESET_ALL}")
            if c == '1': self.target = input("Enter Target: ")
            elif c == '2': self.run_recon(); input("\nEnter...")
            elif c == '3': os.system("termux-telephony-deviceinfo"); input("\nEnter...")
            elif c == '4': repair_and_update(); input("\nEnter...")
            elif c == '5': sys.exit()

if __name__ == "__main__":
    if not os.path.exists("./engine"):
        bootstrap()
    VortexSentinel().menu()

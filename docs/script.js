const printPolicyButton = document.querySelector("[data-print-policy]");

if (printPolicyButton) {
  printPolicyButton.addEventListener("click", () => window.print());
}

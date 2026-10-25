// Dark mode toggle. The initial theme is set by an inline script in default.html.
const root = document.documentElement;
document.getElementById("theme-toggle").addEventListener("click", () => {
  localStorage.theme = root.classList.toggle("dark") ? "dark" : "light";
});
matchMedia("(prefers-color-scheme: dark)").addEventListener("change", (e) => {
  if (!localStorage.theme) root.classList.toggle("dark", e.matches);
});

// Copy buttons for code blocks.
document.querySelectorAll("div.highlighter-rouge").forEach((block) => {
  const button = document.createElement("button");
  button.type = "button";
  button.className = "copy-code";
  button.textContent = "Copy";
  button.addEventListener("click", async () => {
    await navigator.clipboard.writeText(block.querySelector("code").innerText);
    button.textContent = "Copied!";
    setTimeout(() => (button.textContent = "Copy"), 1500);
  });
  block.append(button);
});

// Tag filter and search on the home page. The selected tag is kept in ?tag= so it can be linked to.
const list = document.getElementById("post-list");
if (list) {
  const items = [...list.querySelectorAll("li")];
  const search = document.getElementById("post-search");
  const tagButtons = [...document.querySelectorAll("button[data-tag]")];
  const noResults = document.getElementById("no-results");
  let activeTag = new URLSearchParams(location.search).get("tag");
  let index = null; // url -> full post text, fetched on first search
  let loading = null;

  const apply = () => {
    const words = search.value.toLowerCase().split(/\s+/).filter(Boolean);
    let shown = 0;
    for (const item of items) {
      const tags = item.dataset.tags ? item.dataset.tags.split("|") : [];
      const text = index?.get(item.dataset.url) ?? item.textContent.toLowerCase();
      const visible = (!activeTag || tags.includes(activeTag)) && words.every((w) => text.includes(w));
      item.hidden = !visible;
      if (visible) shown++;
    }
    noResults.classList.toggle("hidden", shown > 0);
    tagButtons.forEach((b) => b.setAttribute("aria-pressed", b.dataset.tag === activeTag));
  };

  tagButtons.forEach((button) =>
    button.addEventListener("click", () => {
      activeTag = activeTag === button.dataset.tag ? null : button.dataset.tag;
      const url = new URL(location);
      activeTag ? url.searchParams.set("tag", activeTag) : url.searchParams.delete("tag");
      history.replaceState(null, "", url);
      apply();
    })
  );

  search.addEventListener("input", async () => {
    loading ??= fetch(search.dataset.index)
      .then((r) => r.json())
      .then((posts) => (index = new Map(posts.map((p) => [p.url, p.text]))));
    await loading;
    apply();
  });

  apply();
}

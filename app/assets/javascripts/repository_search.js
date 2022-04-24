$(document).ready(function () {
  $("#search-field").tokenInput("/api/v1/repositories", {
    theme: "facebook",
    hintText: "Find Repository on Github",
    noResultsText: "0 Repository found",
    searchingText: "Searching Repositories",
    deleteText: "&#x2603;",
    preventDuplicates: true,
    propertyToSearch: "name",
    minChars: 2,
    tokenLimit: 3,
    jsonContainer: "items",
    resultsFormatter: function (item) {
      let htmlResult = `
          <li>
            <img src=${item.owner.avatar_url} title=${item.name} height="40px"
             width="40px" />
            <div class="repo-details">
              <div class='full_name'>
                ${item.name} / ${item.language}
              </div>
              <div class='full_name'>
                <strong> ${item.stargazers_count} </strong> <i class="fa fa-star"></i>
                <strong> ${item.watchers_count} </strong> <i class="fa fa-eye"></i>
              </div>
            </div>
          </li>
        `;
      return htmlResult;
    },
    tokenFormatter: function (item) {
      return `<li><p> ${item.full_name} / ${item.language}</p></li>`;
    },
  });
});

<table>
  <thead>
    <tr>
      <th>Date</th>
      <th>Title</th>
      <th>Excerpt</th>
    </tr>
  </thead>
  <tbody>
    {#foreach $T.d as post}
    <tr>
      <td>{$T.post.Date}</td>
      <td><a href="{$T.post.Link}">{$T.post.Title}</a></td>
      <td>{$T.post.Description}</td>
    </tr>
    {#/for}
  </tbody>
</table>
# WonderAIassistant/R/wonder.R

#' Wonder AI Assistant Interaction
#'
#' This function sends a question to the DeepSeek API and returns the response.
#'
#' @param api_key A character string containing the API key.
#' @param question A character string containing the question to ask.
#'
#' @return A character string containing the generated content.
#' @export
#'
#' @examples
#' \dontrun{
#' api_key <- "your_api_key_here"
#' question <- "hello"
#' Wonder(api_key, question)
#' }
Wonder <- function(api_key = "", question = "") {

  if (!("httr" %in% rownames(installed.packages()))) {
    install.packages("httr")
  }

  if (!("jsonlite" %in% rownames(installed.packages()))) {
    install.packages("httr")
  }
  library(httr)
  library(jsonlite)
  

  url <- "https://api.deepseek.com/chat/completions"

  request_body <- list(
    model = "deepseek-chat",
    messages = list(
      list(role = "system", content = "你是一个强大的r语言的代码助手,你叫做Wonderassistant，有时候我会粘贴一段r语言的报错给你，请帮我解答一下代码报错的原因并给出修改的建议，在给完建议后，请重新把完整的没有注释的代码在最后展示出来。有时候因为我是初学者，可能粘贴的报错给的信息太少了，你也可以提醒我粘贴完全点。有时候我也需要你帮助我写代码，这时候因为我是初学者，我希望你的注释尽力详细，并且一样的，在最后请重新把没有备注的完整的代码展示出来。谢谢你。"),
      list(role = "user", content = question)
    ),
    stream = FALSE
  )
  

  response <- POST(
    url,
    add_headers(
      "Content-Type" = "application/json",
      "Authorization" = paste("Bearer", api_key)
    ),
    body = request_body,
    encode = "json"
  )
  

  if (http_status(response)$category == "Success") {

    response_content <- content(response, "parsed")
    cat(response_content$choices[[1]]$message$content)
  } else {

    print(http_status(response)$message)
  }
}
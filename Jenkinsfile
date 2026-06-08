pipeline {
    agent any
    stages {
        stage('Pull Request Events Only') {
            when {
                expression {
                    def action = (env.GITHUB_PR_ACTION ?: '').toLowerCase()
                    def eventName = (env.GITHUB_EVENT_NAME ?: '').toLowerCase()
                    def isPrCreateOrUpdate = ['opened', 'synchronize'].contains(action)
                    def isCommentEvent = ['created', 'commented'].contains(action) && [
                        env.GITHUB_COMMENT,
                        env.GITHUB_COMMENT_BODY,
                        env.GITHUB_PR_COMMENT
                    ].any { it?.trim() }

                    // Support explicit GitHub event names for comment webhooks as well.
                    if (['issue_comment', 'pull_request_review', 'pull_request_review_comment'].contains(eventName)) {
                        isCommentEvent = true
                    }

                    return env.GITHUB_PR_NUMBER?.trim() && (isPrCreateOrUpdate || isCommentEvent)
                }
            }
            stages {
                stage('Generate GitHub Bot Properties') {
                    steps {
                        sh '''#!/bin/bash -x
env
echo "FORCE_PULL_REQUEST=$CHANGE_ID" > github-bot-properties
REPO_SHORT=$(echo $CHANGE_URL | sed -E 's|^[^/]+//[^/]+/([^/]*/[^/]*)/.*$|\1|')
echo "REPOSITORY=$REPO_SHORT" >> github-bot-properties
'''
                    }
                }

                stage('Trigger GitHub Bot Job') {
                    steps {
                        script {
                            def props = readProperties file: 'github-bot-properties'
                            def params = props.collect { k, v ->
                                string(name: k.toString(), value: v.toString())
                            }

                            build job: 'github-bot', parameters: params
                        }
                    }
                }
            }
        }
    }
}

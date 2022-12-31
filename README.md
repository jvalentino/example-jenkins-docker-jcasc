# Jenkins on Docker using JCaSC

Prerequisites

- https://github.com/jvalentino/example-docker-jenkins

References

- https://github.com/jenkinsci/configuration-as-code-plugin/blob/master/README.md

# (1) Config as Code Plugin

![01](wiki/01.png)

http://localhost:8080/manage/configuration-as-code/viewExport

```yaml
jenkins:
  agentProtocols:
  - "JNLP4-connect"
  - "Ping"
  authorizationStrategy:
    loggedInUsersCanDoAnything:
      allowAnonymousRead: false
  crumbIssuer:
    standard:
      excludeClientIPFromCrumb: false
  disableRememberMe: false
  labelAtoms:
  - name: "built-in"
  markupFormatter: "plainText"
  mode: NORMAL
  myViewsTabBar: "standard"
  numExecutors: 2
  primaryView:
    all:
      name: "all"
  projectNamingStrategy: "standard"
  quietPeriod: 5
  remotingSecurity:
    enabled: true
  scmCheckoutRetryCount: 0
  securityRealm:
    local:
      allowsSignup: false
      enableCaptcha: false
      users:
      - id: "admin"
        name: "admin"
        properties:
        - "myView"
        - preferredProvider:
            providerId: "default"
        - "timezone"
        - mailer:
            emailAddress: "admin@admin.com"
        - "apiToken"
  slaveAgentPort: 50000
  updateCenter:
    sites:
    - id: "default"
      url: "https://updates.jenkins.io/update-center.json"
  views:
  - all:
      name: "all"
  viewsTabBar: "standard"
globalCredentialsConfiguration:
  configuration:
    providerFilter: "none"
    typeFilter: "none"
security:
  apiToken:
    creationOfLegacyTokenEnabled: false
    tokenGenerationOnCreationEnabled: false
    usageStatisticsEnabled: true
  gitHooks:
    allowedOnAgents: false
    allowedOnController: false
  gitHostKeyVerificationConfiguration:
    sshHostKeyVerificationStrategy: "knownHostsFileVerificationStrategy"
  sSHD:
    port: -1
unclassified:
  buildDiscarders:
    configuredBuildDiscarders:
    - "jobBuildDiscarder"
  buildStepOperation:
    enabled: false
  email-ext:
    adminRequiredForTemplateTesting: false
    allowUnregisteredEnabled: false
    charset: "UTF-8"
    debugMode: false
    defaultBody: |-
      $PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:

      Check console output at $BUILD_URL to view the results.
    defaultSubject: "$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!"
    defaultTriggerIds:
    - "hudson.plugins.emailext.plugins.trigger.FailureTrigger"
    maxAttachmentSize: -1
    maxAttachmentSizeMb: -1
    precedenceBulk: false
    watchingEnabled: false
  fingerprints:
    fingerprintCleanupDisabled: false
    storage: "file"
  gitHubConfiguration:
    apiRateLimitChecker: ThrottleForNormalize
  gitHubPluginConfig:
    hookUrl: "http://localhost:8080/github-webhook/"
  globalTimeOutConfiguration:
    operations:
    - "abortOperation"
    overwriteable: false
  injectionConfig:
    allowUntrusted: false
    enabled: false
    injectCcudExtension: false
    injectMavenExtension: false
  junitTestResultStorage:
    storage: "file"
  location:
    adminAddress: "address not configured yet <nobody@nowhere>"
    url: "http://localhost:8080/"
  mailer:
    charset: "UTF-8"
    useSsl: false
    useTls: false
  pollSCM:
    pollingThreadCount: 10
  scmGit:
    addGitTagAction: false
    allowSecondFetch: false
    createAccountBasedOnEmail: false
    disableGitToolChooser: false
    hideCredentials: false
    showEntireCommitSummaryInChanges: false
    useExistingAccountWithSameEmail: false
  timestamper:
    allPipelines: false
    elapsedTimeFormat: "'<b>'HH:mm:ss.S'</b> '"
    systemTimeFormat: "'<b>'HH:mm:ss'</b> '"
tool:
  git:
    installations:
    - home: "git"
      name: "Default"
  mavenGlobalConfig:
    globalSettingsProvider: "standard"
    settingsProvider: "standard"
```

# (2) Restart

docker-compose.yml

```yaml
version: '3.8'
services:
  jenkins:
    image: jenkins/jenkins:lts
    privileged: true
    user: root
    ports:
     - 8080:8080
     - 50000:50000
    container_name: jenkins_jcasc
    volumes:
     - /var/run/docker.sock:/var/run/docker.sock
     - ./jenkins_home:/var/jenkins_home
     - ./jcasc:/var/jcasc
    environment:
     - CASC_JENKINS_CONFIG=/var/jcasc
```



http://localhost:8080/manage/systemInfo

![01](wiki/02.png)

http://localhost:8080/manage/configuration-as-code/

![01](wiki/03.png)

# (3) Reload

jenkins.yaml

```yaml
  location:
    adminAddress: "foo@bar.com"
    url: "http://localhost:8080/"
```

http://localhost:8080/manage/configure

![01](wiki/04.png)






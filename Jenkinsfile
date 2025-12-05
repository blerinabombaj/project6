pipeline {
    agent any
    environment {
        PATH = "/opt/apache-maven-3.9.4/bin:$PATH"
        MAVEN_OPTS = "-Xmx1024m -DforkCount=0"
    }
    stages {
        stage('Build') {
            steps {
                echo "----------- build started ----------"
                sh 'mvn clean compile -DskipTests'
                echo "----------- build completed ----------"
            }
        }
        stage('Test') {
            steps {
                echo "----------- unit test started ----------"
                sh 'mvn clean test -DforkCount=0 -Djacoco.skip=true'
                echo "----------- unit test completed ----------"
            }
        }
        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'SonarScanner'
            }
            steps {
                withSonarQubeEnv('SonarCloud') {
                    sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=robert-devops-workshop -Dsonar.organization=blerinabombaj"
                }
            }
        }
        stage('Success') {
            steps {
                echo "🚀 FULL CI/CD PIPELINE SUCCESS!"
                echo "✅ Build + Test + SonarCloud"
                echo "📊 https://sonarcloud.io/dashboard?id=robert-devops-workshop"
            }
        }
    }
}

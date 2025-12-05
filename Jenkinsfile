pipeline {
    agent any
    environment {
        PATH = "/opt/apache-maven-3.9.4/bin:$PATH"
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
                sh 'mvn clean test'
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
        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: false
                }
            }
        }
        stage('Success') {
            steps {
                echo "🚀 FULL CI/CD PIPELINE SUCCESS!"
                echo "✅ Maven Build + JUnit Tests + SonarCloud"
                echo "📊 https://sonarcloud.io/dashboard?id=robert-devops-workshop"
            }
        }
    }
}

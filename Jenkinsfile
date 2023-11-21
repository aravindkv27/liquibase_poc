def mysqlDriver = "C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\liquibase_poc\\mysql-connector-j-8.0.33.jar"

pipeline {
    agent any
    
    environment {
        DATABASE_RDS_EP = credentials('DATABASE_RDS_EP') 
        DATABASE_RDS_USR = credentials('DATABASE_RDS_USR') 
        DATABASE_RDS_PSD = credentials('DATABASE_RDS_PSD') 
    }
    
    stages {
        // stage('Docker') {
        //     steps {
        //         bat ''
        //     }
        // }
        stage('Test') {
            steps {
                bat 'docker run --rm liquibase/liquibase --version'
            }
        }
        stage('Validate') {
            steps {
                bat 'docker run --rm -v D:\\Projects\\liquibase_poc\\changelogs://liquibase//changelog -v "D:\\Projects\\liquibase_poc\\liquibasedep://liquibase//lib" liquibase/liquibase --url=%DATABASE_RDS_EP% --changeLogFile=changelog.xml --username=%DATABASE_RDS_USR% --password=%DATABASE_RDS_PSD% validate'
            }
        }
        stage('Status') {
            steps {
                bat 'docker run --rm -v D:\\Projects\\liquibase_poc\\changelogs://liquibase//changelog -v D:\\Projects\\liquibase_poc\\liquibasedep://liquibase//lib liquibase/liquibase --url=%DATABASE_RDS_EP% --changeLogFile=changelog.xml --username=%DATABASE_RDS_USR% --password=%DATABASE_RDS_PSD% status'
            }
        }
        stage('Update') {
            steps {
                script {
                    // Execute the Liquibase update command and capture its output
                    def commandOutput = bat(script: 'docker run --rm -v D:\\Projects\\liquibase_poc\\changelogs://liquibase//changelog -v D:\\Projects\\liquibase_poc\\liquibasedep://liquibase//lib liquibase/liquibase --url=%DATABASE_RDS_EP% --changeLogFile=changelog.xml --username=%DATABASE_RDS_USR% --password=%DATABASE_RDS_PSD% update', returnStdout: true).trim()

                    // Store the captured output in a variable
                    env.UPDATE_OUTPUT = commandOutput

                    // Print the captured output
                    echo "Liquibase Update Output: ${env.UPDATE_OUTPUT}"
                }
            }
        }

    }
    
    post {
        always {
            cleanWs()
        }
    }
}
